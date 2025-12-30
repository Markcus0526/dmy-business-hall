package com.damytech.YiDong;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Rect;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewTreeObserver;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.ViewFlipper;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;
import com.damytech.Utils.SmartImageView.SmartImageView;
import org.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

public class FeatureActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;

    private ViewFlipper flipper;
    private ImageView[] mImgSlide = null;
    private ImageView imgCompare;

    ArrayList<String> arrData = new ArrayList<String>();
    SmartImageView[] arrImgView = null;

    float xAtDown;
    float xAtUp;

    int nCurPos = 0;
    private final int SLIDE_IMG_SIZE = 10;
    private final int SLIDE_MARGIN_SIZE = 40;

    private JsonHttpResponseHandler handlerBenefit = new JsonHttpResponseHandler()
    {
        int result = 0;

        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            result = 1;

            arrData = CommMgr.commService.parsegetBenefitList(response);
            if (arrData != null)
                loadFeatureDataView();
            else
            {
                GlobalData.showToast(FeatureActivity.this, getString(R.string.noexist_bndspc));
                finish();
            }
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
        }

        @Override
        public void onFinish() {
            super.onFinish();

            dialog.dismiss();
            if (result == 0)
            {
                GlobalData.showToast(FeatureActivity.this, getString(R.string.network_error));

                long count = GlobalData.getFeatureImgCount(FeatureActivity.this);
                if (count > 0)
                {
                    arrData = new ArrayList<String>();
                    for (int i = 0; i < count; i++)
                    {
                        arrData.add(GlobalData.getFeatureImgPath(FeatureActivity.this, i));
                    }
                    loadFeatureDataView();
                }
            }
        }
    };
    ProgressDialog dialog = null;

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (GlobalData.getTempID(FeatureActivity.this) == 1)
            setContentView(R.layout.activity_feature);
        else if (GlobalData.getTempID(FeatureActivity.this) == 2)
            setContentView(R.layout.activity_feature_2);
        else
            setContentView(R.layout.activity_feature);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlFeatureBack);
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlFeatureBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        initView();

        dialog = ProgressDialog.show(
                FeatureActivity.this,
                "",
                getString(R.string.waiting),
                true,
                false,
                null);
        CommMgr.commService.getBenefitList(handlerBenefit,
                Long.toString(GlobalData.getUserID(FeatureActivity.this)),
                Long.toString(GlobalData.getBrandID(FeatureActivity.this)),
                Long.toString(GlobalData.getSpecID(FeatureActivity.this)));
    }

    private void initView()
    {
        imgCompare = (ImageView) findViewById(R.id.imgCompare);
        imgCompare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(FeatureActivity.this, CompareBrandActivity.class);
                startActivity(intent);
                finish();
            }
        });

        flipper = (ViewFlipper)findViewById(R.id.viewFeature);
        flipper.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if(v != flipper)
                    return false;

                if(event.getAction() == MotionEvent.ACTION_DOWN) {
                    xAtDown = event.getX();
                }
                else if(event.getAction() == MotionEvent.ACTION_UP){
                    xAtUp = event.getX();

                    if( xAtUp < xAtDown ) {
                        flipper.setInAnimation(AnimationUtils.loadAnimation(FeatureActivity.this,
                                R.anim.right_in));
                        flipper.setOutAnimation(AnimationUtils.loadAnimation(FeatureActivity.this,
                                R.anim.left_out));

                        if (nCurPos < arrData.size()-1 )
                        {
                            nCurPos++;
                            flipper.showNext();
                        }
                    }
                    else if (xAtUp > xAtDown){
                        flipper.setInAnimation(AnimationUtils.loadAnimation(FeatureActivity.this,
                                R.anim.left_in));
                        flipper.setOutAnimation(AnimationUtils.loadAnimation(FeatureActivity.this,
                                R.anim.right_out));
                        if (nCurPos > 0)
                        {
                            nCurPos--;
                            flipper.showPrevious();
                        }
                    }

                    for (int i = 0; i < arrData.size(); i++)
                    {
                        if (nCurPos == i)
                            mImgSlide[i].setImageResource(R.drawable.redballoon);
                        else
                            mImgSlide[i].setImageResource(R.drawable.grayballoon);
                    }
                }
                return true;
            }
        });
    }

    private void loadFeatureDataView()
    {
        int nCount = arrData.size();
        long nOldCount = GlobalData.getFeatureImgCount(FeatureActivity.this);
        if (nCount != nOldCount)
        {
            for (int ii = 0; ii < nCount; ii++)
            {
                DownloadImg(ii);
            }
        }
        else
        {
            for (int ii = 0; ii < nCount; ii++)
            {
                String strPath = GlobalData.getFeatureImgPath(FeatureActivity.this, ii);
                if (strPath.equals(arrData.get(ii)) != true)
                {
                    DownloadImg(ii);
                }
            }
        }

        GlobalData.setFeatureImgCount(FeatureActivity.this, nCount);

        mImgSlide = new ImageView[nCount];
        int nWidth = nCount * SLIDE_IMG_SIZE + (nCount-1) * SLIDE_MARGIN_SIZE;
        RelativeLayout rlSlide = new RelativeLayout(rlMainBack.getContext());
        RelativeLayout.LayoutParams rlSlideParam = new RelativeLayout.LayoutParams(nWidth, SLIDE_IMG_SIZE);
        rlSlideParam.addRule(RelativeLayout.ALIGN_PARENT_BOTTOM);
        rlSlideParam.addRule(RelativeLayout.CENTER_HORIZONTAL);
        rlSlideParam.setMargins(-1, -1, -1, SLIDE_IMG_SIZE);
        rlSlide.setLayoutParams(rlSlideParam);

        arrImgView = new SmartImageView[nCount];
        for (int i = 0; i < nCount; i++)
        {
            RelativeLayout rlFeature = new RelativeLayout(flipper.getContext());
            RelativeLayout.LayoutParams rlParam = new RelativeLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.FILL_PARENT);
            rlFeature.setLayoutParams(rlParam);

            arrImgView[i] = new SmartImageView(rlFeature.getContext());
            RelativeLayout.LayoutParams rlImgParam = new RelativeLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.FILL_PARENT);
            arrImgView[i].setLayoutParams(rlImgParam);
            arrImgView[i].setScaleType(ImageView.ScaleType.FIT_XY);
            Uri imgPath = null;
            try
            {
                imgPath = Uri.parse(GlobalData.getLocalFeatureImgPath(FeatureActivity.this, i));
                arrImgView[i].setImageURI(imgPath);
            }
            catch (Exception ex)
            {
                arrImgView[i].setImageResource(R.drawable.defbackimage);
            }

            rlFeature.addView(arrImgView[i]);
            flipper.addView(rlFeature);

            mImgSlide[i] = new ImageView(rlSlide.getContext());
            mImgSlide[i].setId(100+i);
            RelativeLayout.LayoutParams param = new RelativeLayout.LayoutParams(SLIDE_IMG_SIZE, SLIDE_IMG_SIZE);
            if (i == 0)
            {
                mImgSlide[i].setImageResource(R.drawable.redballoon);
                param.addRule(RelativeLayout.ALIGN_LEFT, rlSlide.getId());
            }
            else
            {
                mImgSlide[i].setImageResource(R.drawable.grayballoon);
                param.addRule(RelativeLayout.RIGHT_OF, mImgSlide[i-1].getId());
                param.setMargins(SLIDE_MARGIN_SIZE, -1, -1, -1);
            }

            mImgSlide[i].setLayoutParams(param);
            rlSlide.addView(mImgSlide[i], mImgSlide[i].getLayoutParams());
        }

        rlMainBack.addView(rlSlide, rlSlide.getLayoutParams());
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event)
    {
        if (keyCode == event.KEYCODE_BACK)
        {
            Intent intent = new Intent(FeatureActivity.this, MainMenuActivity.class);
            startActivity(intent);
            finish();
        }

        return super.onKeyDown(keyCode, event);
    }

    private void DownloadImg(final int nNumber)
    {
        final String upgrade_url = arrData.get(nNumber);
        Thread thr = new Thread(new Runnable()
        {
            @Override
            public void run()
            {
                try
                {
                    int nBytesRead = 0;
                    byte[] buf = new byte[1024];

                    URLConnection urlConn = null;
                    URL fileUrl = null;
                    InputStream inStream = null;
                    OutputStream outStream = null;

                    File dir_item = null, file_item = null;

                    fileUrl = new URL(upgrade_url);
                    urlConn = fileUrl.openConnection();
                    inStream = urlConn.getInputStream();
                    String local_file_path = upgrade_url.substring(upgrade_url.lastIndexOf("/") + 1);
                    dir_item = new File(Environment.getExternalStorageDirectory(), "Download");
                    dir_item.mkdirs();
                    file_item = new File(dir_item, local_file_path);

                    local_file_path = file_item.getAbsolutePath();
                    final String real_local_file_path = local_file_path;

                    outStream = new BufferedOutputStream(new FileOutputStream(file_item));

                    while ((nBytesRead = inStream.read(buf)) != -1)
                        outStream.write(buf, 0, nBytesRead);

                    inStream.close();
                    outStream.flush();
                    outStream.close();
                    /////////////////////////////////////////////////////////////////////////

                    GlobalData.setFeatureImgPath(FeatureActivity.this, nNumber, upgrade_url);
                    GlobalData.setLocalFeatureImgPath(FeatureActivity.this, nNumber, local_file_path);
                    runOnUiThread(new Runnable()
                    {
                        @Override
                        public void run()
                        {
                            if (arrImgView[nNumber] != null)
                            {
                                try
                                {
                                    Uri imgPath = Uri.parse(real_local_file_path);
                                    arrImgView[nNumber].setImageURI(imgPath);
                                }
                                catch(Exception ex)
                                {
                                    arrImgView[nNumber].setImageResource(R.drawable.defbackimage);
                                }
                            }
                        }
                    });
                }
                catch (Exception ex)
                {
                    ex.printStackTrace();

                    GlobalData.setFeatureImgPath(FeatureActivity.this, nNumber, "");
                    GlobalData.setFeatureImgPath(FeatureActivity.this, nNumber, "");
                    if (arrImgView[nNumber] != null)
                        arrImgView[nNumber].setImageResource(R.drawable.defbackimage);
                }
            }
        });

        thr.start();
    }
}
