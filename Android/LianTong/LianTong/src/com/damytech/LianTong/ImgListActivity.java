package com.damytech.LianTong;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Rect;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.*;
import android.view.animation.AnimationUtils;
import android.widget.*;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.STData.STString;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.HorizontalPager;
import com.damytech.Utils.ResolutionSet;
import com.damytech.Utils.SmartImageView.SmartImage;
import com.damytech.Utils.SmartImageView.SmartImageView;
import org.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;

public class ImgListActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;

    private HorizontalPager mGallery;
    private ImageView[] mImgSlide = null;

    long nShopID = 0;

    ArrayList<STString> arrData = new ArrayList<STString>();
    SmartImageView[] arrImgView = null;

    private final int SLIDE_IMG_SIZE = 10;
    private final int SLIDE_MARGIN_SIZE = 40;

    long nDetNo = 0;

    private JsonHttpResponseHandler handler = new JsonHttpResponseHandler()
    {
        int result = 0;

        long nRet = 0;
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            result = 1;

            nRet = CommMgr.commService.parsegetAllImgList(response, arrData);
            if (arrData != null)
                loadFeatureDataView();
            else
            {
                GlobalData.showToast(ImgListActivity.this, getString(R.string.noexist_bndspc));
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
                GlobalData.showToast(ImgListActivity.this, getString(R.string.network_error));
                long count = GlobalData.getImgListCount(ImgListActivity.this, nShopID, nDetNo);
                if (count > 0)
                {
                    arrData = new ArrayList<STString>();
                    for (int i = 0; i < count; i++)
                    {
                        STString strData = new STString();
                        strData.data = GlobalData.getImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, i);
                        arrData.add(strData);
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
        setContentView(R.layout.activity_imglist);

        nShopID = GlobalData.getUserID(ImgListActivity.this);
        nDetNo = getIntent().getLongExtra("DetNo", 0);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlImgListBack);
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlImgListBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        initView();

        dialog = ProgressDialog.show(
                ImgListActivity.this,
                "",
                getString(R.string.waiting),
                true,
                false,
                null);
        CommMgr.commService.getAllImgList(handler,
                Long.toString(nShopID),
                Long.toString(nDetNo));
    }

    private void initView()
    {
        mGallery = (HorizontalPager)findViewById(R.id.viewImgList);
        mGallery.setCurrentScreen(0, false);
        mGallery.setOnScreenSwitchListener(new HorizontalPager.OnScreenSwitchListener()	{
            @Override
            public void onScreenSwitched(int screen) {
                mGallery.setCurrentScreen(screen, false);
                if (arrData != null)
                {
                    for (int i = 0; i < arrData.size(); i++)
                    {
                        if (screen == i)
                            mImgSlide[i].setImageResource(R.drawable.redballoon);
                        else
                            mImgSlide[i].setImageResource(R.drawable.grayballoon);
                    }
                }
            }
        });
    }

    private void loadFeatureDataView()
    {
        int nCount = arrData.size();

        long nOldCount = GlobalData.getImgListCount(ImgListActivity.this, nShopID, nDetNo);
        if (nCount != nOldCount)
        {
            for (int i = 0; i < nCount; i++)
            {
                DownloadImg(i);
            }
        }
        else
        {
            for (int i = 0; i < nCount; i++)
            {
                String strPath = GlobalData.getImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, i);
                if (strPath.equals(arrData.get(i)) != true)
                {
                    DownloadImg(i);
                }
            }
        }

        GlobalData.setImgListCount(ImgListActivity.this, nShopID, nDetNo, nCount);

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
            arrImgView[i] = new SmartImageView(mGallery.getContext());
            RelativeLayout.LayoutParams rlImgParam = new RelativeLayout.LayoutParams(LinearLayout.LayoutParams.FILL_PARENT, LinearLayout.LayoutParams.FILL_PARENT);
            arrImgView[i].setLayoutParams(rlImgParam);
            arrImgView[i].setScaleType(ImageView.ScaleType.FIT_XY);

            Uri imgPath = null;
            try
            {
                String strPath = GlobalData.getLocalImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, i);
                if ( strPath.length() > 0 )
                {
                    imgPath = Uri.parse(strPath);
                    arrImgView[i].setImageURI(imgPath);
                }
                else
                    arrImgView[i].setImageResource(R.drawable.defbackimage);
            }
            catch (Exception ex)
            {
                arrImgView[i].setImageResource(R.drawable.defbackimage);
            }

            mGallery.addView(arrImgView[i]);

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
            finish();
        }

        return super.onKeyDown(keyCode, event);
    }

    private void DownloadImg(final int nNumber)
    {
        final String upgrade_url = arrData.get(nNumber).data;
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

                    GlobalData.setImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, nNumber, upgrade_url);
                    GlobalData.setLocalImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, nNumber, local_file_path);
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
                                    arrImgView[nNumber].setTag(real_local_file_path);
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

                    GlobalData.setImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, nNumber, "");
                    GlobalData.setLocalImgListPathWithNo(ImgListActivity.this, nShopID, nDetNo, nNumber, "");
                    if (arrImgView[nNumber] != null)
                        arrImgView[nNumber].setImageResource(R.drawable.defbackimage);
                }
            }
        });

        thr.start();
    }
}
