package com.damytech.DianXin;

import java.util.ArrayList;
import org.json.JSONObject;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Rect;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.STData.STDetailInfo;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;
import com.damytech.Utils.SmartImageView.SmartImageView;

public class CompareKindActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;
    ImageView imgBrand;
    ImageView imgBack;
ListView listDatas;
    
    private PhoneSpecAdapter mAdapter;
    ArrayList<STDetailInfo> arrDatas = new ArrayList<STDetailInfo>();
    
    private JsonHttpResponseHandler handler = new JsonHttpResponseHandler()
    {
        int result = 0;

        @Override
        public void onSuccess(JSONObject jsonData)
        {
            result = 1;

            dialog.dismiss();
            long nRet = CommMgr.commService.parsegetSameBrandList(jsonData, arrDatas);
            if (nRet == 0)
            {
            	if (arrDatas != null && arrDatas.size() > 0)
            	{
            		mAdapter = new PhoneSpecAdapter(CompareKindActivity.this, 0, arrDatas);
                    listDatas.setCacheColorHint(Color.parseColor("#FFF1F1F1"));
                    listDatas.setDivider(new ColorDrawable(Color.parseColor("#FFCCCCCC")));
                    listDatas.setDividerHeight(2);
                    listDatas.setAdapter(mAdapter);
            	}
                /*
            	else
            	{
            		GlobalData.showToast(CompareKindActivity.this, getString(R.string.noexist_bndspc));
                	finish();
            	}
            	*/
            }
            /*
            else
            {
            	GlobalData.showToast(CompareKindActivity.this, getString(R.string.noexist_bndspc));
            	finish();
            }
            */
        }

        @Override
        public void onFailure(Throwable ex, String exception)
        {
            ex.printStackTrace();
        }

        @Override
        public void onFinish()
        {
        	dialog.dismiss();
            if (result == 2)
                GlobalData.showToast(CompareKindActivity.this, getString(R.string.service_error));
            else if (result == 0)
                GlobalData.showToast(CompareKindActivity.this, getString(R.string.network_error));
        }
    };
    private ProgressDialog dialog;

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (GlobalData.getTempID(CompareKindActivity.this) == 1)
            setContentView(R.layout.activity_comparekind);
        else if (GlobalData.getTempID(CompareKindActivity.this) == 2)
            setContentView(R.layout.activity_comparekind_2);
        else
            setContentView(R.layout.activity_comparekind);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlCompareKindBack);
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlCompareKindBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        initView();
        
        dialog = ProgressDialog.show(
        		CompareKindActivity.this,
        		"",
        		getString(R.string.waiting),
        		true,
        		false,
        		null);
        CommMgr.commService.getSameKindList(handler, Long.toString(GlobalData.getUserID(CompareKindActivity.this)),
                Long.toString(GlobalData.getBrandID(CompareKindActivity.this)),
                Long.toString(GlobalData.getSpecID(CompareKindActivity.this)));
    }

    private void initView()
    {
        imgBrand = (ImageView) findViewById(R.id.imgKind_Brand);
        imgBrand.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(CompareKindActivity.this, CompareBrandActivity.class);
                startActivity(intent);
                finish();
            }
        });

        imgBack = (ImageView) findViewById(R.id.imgKind_Back);
        imgBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(CompareKindActivity.this, FeatureActivity.class);
                startActivity(intent);
                finish();
            }
        });
        
        listDatas = (ListView) findViewById(R.id.listCompareKind_Datas);
    }

    public class PhoneSpecAdapter extends ArrayAdapter<STDetailInfo>
    {
    	Context mContext;
    	ArrayList<STDetailInfo> infoList = null;
    	
    	public PhoneSpecAdapter(Context ctx, int resourceId, ArrayList<STDetailInfo> list) {
            super(ctx, resourceId, list);
            this.mContext = ctx;
            this.infoList = list;
        }
    	
    	@Override
        public int getCount() {
            return infoList.size();
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            
            if (v == null)
            {
                LayoutInflater inflater = (LayoutInflater)mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
                v = inflater.inflate(R.layout.view_phonespec, null);
                RelativeLayout rlBack = (RelativeLayout)v.findViewById(R.id.rlPhoneSpecBack);
                ResolutionSet._instance.iterateChild(rlBack);
            }

            SmartImageView imgPhoto = (SmartImageView)v.findViewById(R.id.imgPhoneSpec_Phone);
            imgPhoto.setImageUrl(infoList.get(position).imgpath, R.drawable.defphone);
            TextView lblName = (TextView) v.findViewById(R.id.lblPhoneSpec_Name);
            if (infoList.get(position).name != null && infoList.get(position).name.equals("null") == false)
                lblName.setText(infoList.get(position).name);
            else
                lblName.setText(getString(R.string.notcontent));
            TextView lblPrice = (TextView) v.findViewById(R.id.lblCostVal);
            String strPrice = "";
            try
            {
                int nPrice = (int)(infoList.get(position).price);
                if (nPrice == infoList.get(position).price)
                {
                    strPrice = String.format("%.0f", infoList.get(position).price);
                }
                else
                {
                    strPrice = Double.toString(infoList.get(position).price);
                }
            } catch(Exception ex) {
                strPrice = Double.toString(infoList.get(position).price);
            }
            lblPrice.setText(" ： " + strPrice);
            TextView lblSize = (TextView) v.findViewById(R.id.lblSizeVal);
            if (infoList.get(position).dispsize != null && infoList.get(position).dispsize.equals("null") == false)
                lblSize.setText(" ： " + infoList.get(position).dispsize);
            else
                lblSize.setText(getString(R.string.notcontent));
            TextView lblCPU = (TextView) v.findViewById(R.id.lblCpuVal);
            if (infoList.get(position).cpu != null && infoList.get(position).cpu.equals("null") == false)
                lblCPU.setText(" ： " + infoList.get(position).cpu);
            else
                lblCPU.setText(getString(R.string.notcontent));
            TextView lblMemSize = (TextView) v.findViewById(R.id.lblMemVal);
            if (infoList.get(position).memsize != null && infoList.get(position).memsize.equals("null") == false)
                lblMemSize.setText(" ： " + infoList.get(position).memsize);
            else
                lblMemSize.setText(getString(R.string.notcontent));
            TextView lblCamera = (TextView) v.findViewById(R.id.lblCameraVal);
            if (infoList.get(position).pixcnt != null && infoList.get(position).pixcnt.equals("null") == false)
                lblCamera.setText(" ： " + infoList.get(position).pixcnt);
            else
                lblCamera.setText(getString(R.string.notcontent));
            TextView lblSys = (TextView) v.findViewById(R.id.lblSysVal);
            if (infoList.get(position).osver != null && infoList.get(position).osver.equals("null") == false)
                lblSys.setText(" ： " + infoList.get(position).osver);
            else
                lblSys.setText(getString(R.string.notcontent));

            RelativeLayout rlBack = (RelativeLayout)v.findViewById(R.id.rlPhoneSpecBack);
            rlBack.setTag(infoList.get(position).uid);
            rlBack.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Long nVal = (Long) v.getTag();
                    Intent intent = new Intent(CompareKindActivity.this, ImgListActivity.class);
                    intent.putExtra("DetNo", nVal.longValue());
                    startActivity(intent);
                }
            });

            return v;
        }
    }
    
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event)
    {
        if (keyCode == event.KEYCODE_BACK)
        {
            Intent intent = new Intent(CompareKindActivity.this, FeatureActivity.class);
            startActivity(intent);
            finish();
        }

        return super.onKeyDown(keyCode, event);
    }
}
