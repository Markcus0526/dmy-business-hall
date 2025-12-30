package com.damytech.LianTong;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Rect;
import android.os.Build;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.view.*;
import android.widget.*;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.AsyncHttpResponseHandler;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.STData.STBndSpcInfo;
import com.damytech.STData.STRegion;
import com.damytech.STData.STShop;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;
import org.json.JSONArray;
import org.json.JSONObject;
import java.util.ArrayList;

public class MainActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;

    private final int PROV_ADAPTER = 0;
    private final int CITY_ADAPTER = 1;
    private final int AREA_ADAPTER = 2;
    private final int SHOP_ADAPTER = 3;

    private int curAdapter = PROV_ADAPTER;

    ArrayList<STRegion> arrRegions = new ArrayList<STRegion>();
    ArrayList<STShop> arrShops = new ArrayList<STShop>();

    STRegion curProv = null, curCity = null, curArea = null;
    long curRegionID = 0;
	long curShopID = 0;

    ProgressDialog progDlg = null;
    private Button btnOK;

    TextView txtProv = null, txtCity = null, txtArea = null, txtShop = null;
    ImageButton btnProv = null, btnCity = null, btnArea = null, btnShop = null;

    RelativeLayout listLayout = null;
    ListView adapterListView = null;
    ItemAdapter adapter = null;

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (GlobalData.getFirstLogin(MainActivity.this) == 0)
        {
            Intent intent = new Intent(MainActivity.this, LogoActivity.class);
            startActivity(intent);
            finish();

            return;
        }

        initView();

        rlMainBack = (RelativeLayout)findViewById(R.id.rlMainBack);        
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlMainBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        progDlg = new ProgressDialog(MainActivity.this);
        progDlg.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        progDlg.setCancelable(false);
        progDlg.setMessage(getString(R.string.waiting));
        progDlg.show();
        CommMgr.commService.GetShopList(logs_handler);
    }

    public void initView()
    {
        txtProv = (TextView)findViewById(R.id.txt_prov);
        txtCity = (TextView)findViewById(R.id.txt_city);
        txtArea = (TextView)findViewById(R.id.txt_area);
        txtShop = (TextView)findViewById(R.id.txt_shop);

        btnProv = (ImageButton)findViewById(R.id.btn_sel_prov);
        btnProv.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                onClickProv();
            }
        });

        btnCity = (ImageButton)findViewById(R.id.btn_sel_city);
        btnCity.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                onClickCity();
            }
        });

        btnArea = (ImageButton)findViewById(R.id.btn_sel_area);
        btnArea.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                onClickArea();
            }
        });

        btnShop = (ImageButton)findViewById(R.id.btn_sel_shop);
        btnShop.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                onClickShop();
            }
        });

        btnOK = (Button) findViewById(R.id.btnMain_OK);
        btnOK.setOnClickListener( new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            	if (curShopID == 0)
            	{
            		return;
            	}
            	
                String strBrand = Build.BRAND;
                String strSpec = Build.MODEL;

                DisplayMetrics displayMetrics = new DisplayMetrics();
                WindowManager wm = (WindowManager) getApplicationContext().getSystemService(Context.WINDOW_SERVICE); // the results will be higher than using the activity context object or the getWindowManager() shortcut
                wm.getDefaultDisplay().getMetrics(displayMetrics);
                int screenWidth = displayMetrics.widthPixels;
                int screenHeight = displayMetrics.heightPixels;

                progDlg = new ProgressDialog(MainActivity.this);
                progDlg.setProgressStyle(ProgressDialog.STYLE_SPINNER);
                progDlg.setCancelable(false);
                progDlg.setMessage(getString(R.string.waiting));
                progDlg.show();
                CommMgr.commService.getBndSpcID(handlerBndSpec, Long.toString(curShopID), strBrand, strSpec, Integer.toString(screenWidth), Integer.toString(screenHeight));
            }
        });

        listLayout = (RelativeLayout)findViewById(R.id.list_layout);
        listLayout.setClickable(true);
		listLayout.setOnClickListener(new View.OnClickListener()
		{
			@Override
			public void onClick(View v)
			{
				listLayout.setVisibility(View.GONE);
			}
		});
        adapterListView = (ListView)findViewById(R.id.adapter_list);
        adapter = new ItemAdapter();
        adapterListView.setAdapter(adapter);
    }

    private String szTemp = "";
    private Thread thread = new Thread(new Runnable()
    {
        @Override
        public void run()
        {
            try
            {
                JSONObject jsonObject = new JSONObject(szTemp);
                int nRetCode = jsonObject.getInt("RETCODE");
                String szMsg = jsonObject.getString("RETMSG");

                JSONObject objResult = jsonObject.getJSONObject("RETDATA");

                JSONArray arrJsonRegions = objResult.getJSONArray("Regions");
                JSONArray arrJsonShops = objResult.getJSONArray("Shops");

                for (int i = 0; i < arrJsonRegions.length(); i++)
                {
                    STRegion regionInfo = STRegion.decodeFromJSON(arrJsonRegions.getJSONObject(i));
                    arrRegions.add(regionInfo);
                }

                for (int i = 0; i < arrJsonShops.length(); i++)
                {
                    STShop shopInfo = STShop.decodeFromJSON(arrJsonShops.getJSONObject(i));
                    arrShops.add(shopInfo);
                }

                if (arrRegions != null && arrRegions.size() != 0)
                {
                    curProv = arrRegions.get(0);
                    ArrayList<STRegion> arrDefaultCities = curProv.arrSubAreas;
                    if (arrDefaultCities != null && arrDefaultCities.size() > 0)
                    {
                        curCity = arrDefaultCities.get(0);
                        ArrayList<STRegion> arrDefaultAreas = curCity.arrSubAreas;
                        if (arrDefaultAreas != null && arrDefaultAreas.size() > 0)
                        {
                            curArea = arrDefaultAreas.get(0);

                            runOnUiThread(new Runnable()
                            {
                                @Override
                                public void run()
                                {
                                    txtProv.setText(curProv.name);
                                    txtCity.setText(curCity.name);
                                    txtArea.setText(curArea.name);
                                    curRegionID = curArea.uid;

                                    setDefaultShop();
                                }
                            });
                        }
                        else
                        {
                            runOnUiThread(new Runnable()
                            {
                                @Override
                                public void run()
                                {
                                    txtProv.setText(curProv.name);
                                    txtCity.setText(curCity.name);
                                    txtArea.setText("");
                                    curRegionID = curCity.uid;
                                    setDefaultShop();
                                }
                            });
                        }
                    }
                    else
                    {
                        runOnUiThread(new Runnable()
                        {
                            @Override
                            public void run()
                            {
                                txtCity.setText("");
                                txtArea.setText("");
                                txtProv.setText(curProv.name);
                                curRegionID = curProv.uid;
                                setDefaultShop();
                            }
                        });
                    }
                }
                else
                {
                    runOnUiThread(new Runnable()
                    {
                        @Override
                        public void run()
                        {
                            txtCity.setText("");
                            txtArea.setText("");
                            txtProv.setText("");
                            curRegionID = 0;
                            curShopID = 0;
                        }
                    });
                }
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }

            runOnUiThread(new Runnable()
            {
                @Override
                public void run()
                {
                    progDlg.dismiss();
                }
            });
        }
    });

    private AsyncHttpResponseHandler logs_handler = new AsyncHttpResponseHandler()
    {
        @Override
        public void onSuccess(String content) {
            super.onSuccess(content);

            szTemp = content;
            progDlg.setMessage(getResources().getString(R.string.STR_LOADING));
            thread.start();
        }

        @Override
        public void onFailure(Throwable error, String content) {
            super.onFailure(error, content);    //To change body of overridden methods use File | Settings | File Templates.

            txtCity.setText("");
            txtArea.setText("");
            txtProv.setText("");
            curRegionID = 0;
            setDefaultShop();

            progDlg.dismiss();
        }
    };
    
    private void setDefaultShop()
	{
		STShop shopinfo = getShopFromRegionID(curRegionID);
		if (shopinfo == null)
		{
			txtShop.setText("");
			curShopID = 0;
			return;
		}

		txtShop.setText(shopinfo.shopname);
		curShopID = shopinfo.uid;
	}

    private JsonHttpResponseHandler handlerBndSpec = new JsonHttpResponseHandler()
    {
        int result = 0;

        @Override
        public void onSuccess(JSONObject jsonData)
        {
            result = 1;

            progDlg.dismiss();
            STBndSpcInfo info = new STBndSpcInfo();
            long nRet = CommMgr.commService.parsegetBndSpcID(jsonData, info);
            if (nRet == 0)
            {
                if (info.brandid == 0 || info.specid == 0)
                {
                    GlobalData.showToast(MainActivity.this, getString(R.string.noexist_bndspc));
                    MainActivity.this.finish();
                }
                else
                {
                	GlobalData.setUserID(MainActivity.this, curShopID);
                    GlobalData.setBrandID(MainActivity.this, info.brandid);
                    GlobalData.setSpecID(MainActivity.this, info.specid);
                    GlobalData.setCompanyName(MainActivity.this, info.title);
                    GlobalData.setFirstLogin(MainActivity.this);

                    Intent intent = new Intent(MainActivity.this, LogoActivity.class);
                    startActivity(intent);
                    finish();
                }
            }
            else
            {
                GlobalData.showToast(MainActivity.this, getString(R.string.noexist_bndspc));
                MainActivity.this.finish();
            }
        }

        @Override
        public void onFailure(Throwable ex, String exception)
        {
            ex.printStackTrace();
        }

        @Override
        public void onFinish()
        {
            progDlg.dismiss();
            if (result == 2)
                GlobalData.showToast(MainActivity.this, getString(R.string.service_error));
            else if (result == 0)
                GlobalData.showToast(MainActivity.this, getString(R.string.network_error));
        }
    };

    private STShop getShopFromRegionID(long regionid)
    {
        if (arrShops == null || arrShops.size() == 0)
            return null;

        for (int i = 0; i < arrShops.size(); i++)
        {
            STShop shopInfo = arrShops.get(i);
            if (shopInfo.regionid == curRegionID)
            {
                return shopInfo;
            }
        }

        return null;
    }

    private void onClickProv()
    {
        if (arrRegions == null || arrRegions.size() == 0)
            return;

        curAdapter = PROV_ADAPTER;
        adapter.notifyDataSetChanged();
        adapterListView.setSelectionAfterHeaderView();
        listLayout.setVisibility(View.VISIBLE);
    }

    private void onClickCity()
    {
        if (curProv == null || curProv.arrSubAreas == null || curProv.arrSubAreas.size() == 0)
            return;

        curAdapter = CITY_ADAPTER;
        adapter.notifyDataSetChanged();
        adapterListView.setSelectionAfterHeaderView();
        listLayout.setVisibility(View.VISIBLE);
    }

    private void onClickArea()
    {
        if (curCity == null || curCity.arrSubAreas == null || curCity.arrSubAreas.size() == 0)
            return;

        curAdapter = AREA_ADAPTER;
        adapter.notifyDataSetChanged();
        adapterListView.setSelectionAfterHeaderView();
        listLayout.setVisibility(View.VISIBLE);
    }

    private void onClickShop()
    {
        if (arrShops == null || arrShops.size() == 0)
            return;

        curAdapter = SHOP_ADAPTER;
        adapter.notifyDataSetChanged();
        adapterListView.setSelectionAfterHeaderView();
        listLayout.setVisibility(View.VISIBLE);
    }
    
    private STShop getShopInfoFromIndex(int position)
	{
		int nIndex = 0;
		STShop shopInfo = null;
		for (int i = 0; i < arrShops.size(); i++)
		{
			shopInfo = arrShops.get(i);
			if (shopInfo.regionid == curRegionID)
			{
				if (nIndex == position)
					return shopInfo;
				else
					nIndex++;
			}
		}
		return shopInfo;
	}

    public class ItemAdapter extends BaseAdapter
    {
        @Override
        public int getCount() {
            if (curAdapter == PROV_ADAPTER)
            {
                if (arrRegions == null)
                    return 0;
                return arrRegions.size();
            }
            else if (curAdapter == CITY_ADAPTER)
            {
                if (curProv == null || curProv.arrSubAreas == null)
                    return 0;
                return curProv.arrSubAreas.size();
            }
            else if (curAdapter == AREA_ADAPTER)
            {
                if (curCity == null || curCity.arrSubAreas == null)
                    return 0;
                return curCity.arrSubAreas.size();
            }
            else if (curAdapter == SHOP_ADAPTER)
            {
                if (arrShops == null)
                    return 0;

                int nCount = 0;
				for (int i = 0; i < arrShops.size(); i++)
				{
					STShop shop = arrShops.get(i);
					if (shop.regionid == curRegionID)
						nCount++;
				}
				return nCount;
            }

            return 0;
        }

        @Override
        public Object getItem(int position) {
            if (curAdapter == PROV_ADAPTER)
            {
                return arrRegions.get(position);
            }
            else if (curAdapter == CITY_ADAPTER)
            {
                return curProv.arrSubAreas.get(position);
            }
            else if (curAdapter == AREA_ADAPTER)
            {
                return curCity.arrSubAreas.get(position);
            }
            else if (curAdapter == SHOP_ADAPTER)
            {
            	getShopInfoFromIndex(position);
            }

            return null;
        }

        @Override
        public long getItemId(int position) {
            return position;
        }

        @Override
        public boolean hasStableIds() {
            return true;
        }

        @Override
        public boolean isEmpty() {
            return getCount() == 0;
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            STRegion regionInfo = null;
            STShop shopInfo = null;

            if (curAdapter == PROV_ADAPTER)
            {
                regionInfo = arrRegions.get(position);
            }
            else if (curAdapter == CITY_ADAPTER)
            {
                regionInfo = curProv.arrSubAreas.get(position);
            }
            else if (curAdapter == AREA_ADAPTER)
            {
                regionInfo = curCity.arrSubAreas.get(position);
            }
            else if (curAdapter == SHOP_ADAPTER)
            {
                shopInfo = getShopInfoFromIndex(position);
            }
            else
            {
                return null;
            }

            if (convertView == null)
            {
                convertView = new RelativeLayout(parent.getContext());
                AbsListView.LayoutParams layoutParams = new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, 90);
                convertView.setLayoutParams(layoutParams);
                convertView.setBackgroundColor(Color.GRAY);

                TextView txtItem = new TextView(convertView.getContext());
                txtItem.setTextSize(TypedValue.COMPLEX_UNIT_PX, 35);
                txtItem.setTextColor(Color.WHITE);
                txtItem.setPadding(40, 0, 0, 0);
                txtItem.setGravity(Gravity.CENTER_VERTICAL);
                AbsListView.LayoutParams txtLayoutParams = new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, AbsListView.LayoutParams.MATCH_PARENT);
                txtItem.setLayoutParams(txtLayoutParams);
                if (regionInfo != null)
                    txtItem.setText(regionInfo.name);
                else
                    txtItem.setText(shopInfo.shopname);
                ((RelativeLayout)convertView).addView(txtItem);

                Button btnItem = new Button(convertView.getContext());
                btnItem.setBackgroundResource(R.drawable.btn_empty);
                AbsListView.LayoutParams btnLayoutParams = new AbsListView.LayoutParams(AbsListView.LayoutParams.MATCH_PARENT, AbsListView.LayoutParams.MATCH_PARENT);
                btnItem.setLayoutParams(btnLayoutParams);
                if (regionInfo != null)
                {
                    btnItem.setTag("" + regionInfo.uid);
                    btnItem.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            String szUid = (String)v.getTag();
                            long uid = Long.parseLong(szUid);

                            onSelectRegion(uid);
                        }
                    });
                }
                else
                {
                    btnItem.setTag("" + shopInfo.uid);
                    btnItem.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            String szUid = (String)v.getTag();
                            long uid = Long.parseLong(szUid);

                            onSelectShop(uid);
                        }
                    });
                }

                ((RelativeLayout)convertView).addView(btnItem);
                ResolutionSet._instance.iterateChild(convertView);

                STViewHolder viewHolder = new STViewHolder();
                viewHolder.btnItem = btnItem;
                viewHolder.txtItem = txtItem;

                convertView.setTag(viewHolder);
            }
            else
            {
                STViewHolder viewHolder = (STViewHolder)convertView.getTag();

                if (regionInfo != null)
                {
                	viewHolder.txtItem.setText(regionInfo.name);
					viewHolder.btnItem.setTag("" + regionInfo.uid);
					viewHolder.btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectRegion(uid);
						}
					});
                }
                else if (shopInfo != null)
				{
					viewHolder.txtItem.setText(shopInfo.shopname);
					viewHolder.btnItem.setTag("" + shopInfo.uid);

					viewHolder.btnItem.setOnClickListener(new View.OnClickListener() {
						@Override
						public void onClick(View v) {
							String szUid = (String)v.getTag();
							long uid = Long.parseLong(szUid);

							onSelectShop(uid);
						}
					});

				}
            }

            return convertView;
        }
    }

    public class STViewHolder
    {
        public TextView txtItem = null;
        public Button btnItem = null;
    }

    private STRegion getRegionFromID(long uid)
    {
        if (arrRegions == null)
            return null;

        for (int i = 0; i < arrRegions.size(); i++)
        {
            STRegion prov = arrRegions.get(i);
            if (prov.uid == uid)
                return prov;

            if (prov.arrSubAreas == null)
                continue;

            for (int j = 0; j < prov.arrSubAreas.size(); j++)
            {
                STRegion city = prov.arrSubAreas.get(j);
                if (city.uid == uid)
                    return city;

                if (city.arrSubAreas == null)
                    continue;

                for (int k = 0; k < city.arrSubAreas.size(); k++)
                {
                    STRegion area = city.arrSubAreas.get(k);
                    if (area.uid == uid)
                        return area;
                }
            }
        }

        return null;
    }

    private STShop getShopFromID(long uid)
    {
        if (arrShops == null)
            return null;

        for (int i = 0; i < arrShops.size(); i++)
        {
            STShop shop = arrShops.get(i);
            if (shop.uid == uid)
                return shop;
        }

        return null;
    }

    private void onSelectRegion(long uid)
    {
        listLayout.setVisibility(View.GONE);

        if (curAdapter == PROV_ADAPTER)
        {
            STRegion curRegion = getRegionFromID(uid);
            curProv = curRegion;
            ArrayList<STRegion> arrCities = curProv.arrSubAreas;
            if (arrCities != null && arrCities.size() > 0)
            {
                curCity = arrCities.get(0);
                ArrayList<STRegion> arrAreas = curCity.arrSubAreas;
                if (arrAreas != null && arrAreas.size() > 0)
                {
                    curArea = arrAreas.get(0);

                    txtProv.setText(curProv.name);
                    txtCity.setText(curCity.name);
                    txtArea.setText(curArea.name);
                    curRegionID = curArea.uid;

                    setDefaultShop();
                }
                else
                {
                    txtProv.setText(curProv.name);
                    txtCity.setText(curCity.name);
                    txtArea.setText("");
                    curRegionID = curCity.uid;
                    setDefaultShop();
                }
            }
            else
            {
                txtCity.setText("");
                txtArea.setText("");
                txtProv.setText(curProv.name);
                curRegionID = curProv.uid;
                setDefaultShop();
            }
        }
        else if (curAdapter == CITY_ADAPTER)
        {
            STRegion curRegion = getRegionFromID(uid);
            curCity = curRegion;
            ArrayList<STRegion> arrAreas = curCity.arrSubAreas;
            if (arrAreas != null && arrAreas.size() > 0)
            {
                curArea = arrAreas.get(0);

                txtProv.setText(curProv.name);
                txtCity.setText(curCity.name);
                txtArea.setText(curArea.name);
                curRegionID = curArea.uid;

                setDefaultShop();
            }
            else
            {
                txtProv.setText(curProv.name);
                txtCity.setText(curCity.name);
                txtArea.setText("");
                curRegionID = curCity.uid;
                setDefaultShop();
            }
        }
        else if (curAdapter == AREA_ADAPTER)
        {
            STRegion curRegion = getRegionFromID(uid);
            curArea = curRegion;

            txtProv.setText(curProv.name);
            txtCity.setText(curCity.name);
            txtArea.setText(curArea.name);
            curRegionID = curArea.uid;

            setDefaultShop();
        }
    }


    private void onSelectShop(long uid)
    {
        listLayout.setVisibility(View.GONE);

        if (curAdapter == SHOP_ADAPTER)
        {
            STShop curShop = getShopFromID(uid);
            if (curShop == null)
            {
                txtShop.setText("");
				curShopID = 0;
            }
            else
            {
                txtShop.setText(curShop.shopname);
				curShopID = curShop.uid;
            }
        }
    }
}
