package com.damytech.DianXin;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Rect;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.RotateAnimation;
import android.widget.*;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.STData.STString;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;
import com.damytech.Utils.SmartImageView.SmartImageView;
import org.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;

public class MainMenuActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;

    ImageView imgFeature;
    ImageView imgTag;
    ImageView imgExit;
    ImageView imgCourtesy;
    SmartImageView imgBack;

    TextView lblName;
    int nNamePos = 0;
    int nNameWidth = 0;
    int nDisplayWidth = 0;
    Handler handler = null;

    STString info = new STString();
    long nServiceRet = -1;

    private String upgrade_url = "";
    private String local_file_path = "";

    private JsonHttpResponseHandler handlerFirstPage = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nServiceRet = CommMgr.commService.parsegetFirstPageImgPath(response, info);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
        }

        @Override
        public void onFinish() {
            super.onFinish();

            dialog.dismiss();
            String oldMainMenuPath = GlobalData.getMainMenuImgPath(MainMenuActivity.this);
            if ( info.data == null || (info.data != null && info.data.length() == 0))
            {
                if (oldMainMenuPath.length() == 0)
                {
                    imgBack.setImageResource(R.drawable.defbackimage);
                }
                else
                {
                    try {
                        Uri imgPath = Uri.parse(GlobalData.getLocalMainMenuImgPath(MainMenuActivity.this));
                        imgBack.setImageURI(imgPath);
                    }
                    catch (Exception ex)
                    {
                        imgBack.setImageResource(R.drawable.defbackimage);
                    }
                }
                return;
            }

            if (info.data != null && info.data.length() > 0)
            {
                if (info.data.equals(GlobalData.getMainMenuImgPath(MainMenuActivity.this)) == true)
                {
                    String strLocalMainMenuPath = GlobalData.getLocalMainMenuImgPath(MainMenuActivity.this);
                    Uri imgPath = Uri.parse(strLocalMainMenuPath);
                    imgBack.setImageURI(imgPath);
                }
                else
                {
                    upgrade_url = info.data;
                    InstallNewApp();
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
        if (GlobalData.getTempID(MainMenuActivity.this) == 1)
            setContentView(R.layout.activity_mainmenu);
        else if (GlobalData.getTempID(MainMenuActivity.this) == 2)
            setContentView(R.layout.activity_mainmenu_2);
        else
            setContentView(R.layout.activity_mainmenu);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlMainMenuBack);
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlMainMenuBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        initView();

        dialog = ProgressDialog.show(
                MainMenuActivity.this,
                "",
                getString(R.string.waiting),
                true,
                false,
                null);
        CommMgr.commService.getFirstPageImgPath(handlerFirstPage,
                Long.toString(GlobalData.getUserID(MainMenuActivity.this)),
                Long.toString(GlobalData.getBrandID(MainMenuActivity.this)),
                Long.toString(GlobalData.getSpecID(MainMenuActivity.this)));
    }

    private void initView()
    {
        lblName = (TextView) findViewById(R.id.lblCompanyName);
        lblName.setText(GlobalData.getCompanyName(MainMenuActivity.this) + getString(R.string.wellcome));
        lblName.getViewTreeObserver().addOnGlobalLayoutListener( new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                nNameWidth = lblName.getMeasuredWidth();
            }
        });

        imgFeature = (ImageView) findViewById(R.id.imgFeature);
        imgFeature.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainMenuActivity.this, FeatureActivity.class);
                startActivity(intent);
                finish();
            }
        });

        imgTag = (ImageView) findViewById(R.id.imgTag);
        imgTag.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainMenuActivity.this, StatisticsActivity.class);
                startActivity(intent);
                finish();
            }
        });

        imgExit = (ImageView) findViewById(R.id.imgExit);
        imgExit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        imgCourtesy = (ImageView) findViewById(R.id.imgCourtesy);
        Animation animation = new RotateAnimation(0f, 720*60*10, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);
        animation.setDuration(600000);
        animation.setRepeatCount(Animation.INFINITE);
        animation.setRepeatMode(Animation.INFINITE);
        animation.setInterpolator(AnimationUtils.loadInterpolator(MainMenuActivity.this, android.R.anim.linear_interpolator));
        imgCourtesy.setAnimation(animation);
        imgCourtesy.startAnimation(animation);
        imgCourtesy.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainMenuActivity.this, CourtesyActivity.class);
                startActivity(intent);
            }
        });

        imgBack = (SmartImageView) findViewById(R.id.viewMainMenu_Photo);
    }

    @Override
    public void onResume()
    {
        super.onResume();

        DisplayMetrics displaymetrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(displaymetrics);
        nDisplayWidth = displaymetrics.widthPixels;

        handler = new Handler()
        {
            @Override
            public void handleMessage(Message msg)
            {
                if (nNamePos < (-1)*nNameWidth)
                    nNamePos = nDisplayWidth;
                RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.MATCH_PARENT);
                params.setMargins(nNamePos, 0, 0, 0);
                lblName.setLayoutParams(params);

                nNamePos -= 5;

                handler.sendEmptyMessageDelayed(0, 200);
            }
        };

        handler.sendEmptyMessageDelayed(0, 200);
    }

    private void InstallNewApp()
    {
        Thread thr = new Thread(new Runnable()
        {
            @Override
            public void run()
            {
                try
                {
                    int nBytesRead = 0, nByteWritten = 0;
                    byte[] buf = new byte[1024];

                    URLConnection urlConn = null;
                    URL fileUrl = null;
                    InputStream inStream = null;
                    OutputStream outStream = null;

                    File dir_item = null, file_item = null;

                    // Show progress dialog
                    runOnUiThread(runnable_showProgress);

                    // Downloading file from address
                    fileUrl = new URL(upgrade_url);
                    urlConn = fileUrl.openConnection();
                    inStream = urlConn.getInputStream();
                    local_file_path = upgrade_url.substring(upgrade_url.lastIndexOf("/") + 1);
                    dir_item = new File(Environment.getExternalStorageDirectory(), "Download");
                    dir_item.mkdirs();
                    file_item = new File(dir_item, local_file_path);

                    local_file_path = file_item.getAbsolutePath();

                    outStream = new BufferedOutputStream(new FileOutputStream(file_item));

                    while ((nBytesRead = inStream.read(buf)) != -1)
                    {
                        outStream.write(buf, 0, nBytesRead);
                        nByteWritten += nBytesRead;
                        UpdateProgress(nByteWritten);
                    }

                    UpdateProgress(getResources().getString(R.string.download_success));

                    inStream.close();
                    outStream.flush();
                    outStream.close();
                    /////////////////////////////////////////////////////////////////////////

                    // Hide progress dialog
                    runOnUiThread(runnable_hideProgress);

                    // Finish downloading and install
                    runOnUiThread(runnable_finish_download);
                }
                catch (Exception ex)
                {
                    ex.printStackTrace();
                    runOnUiThread(runnable_download_error);
                }
            }
        });

        thr.start();
    }


    private void UpdateProgress(int nValue)
    {
        double fVal = nValue / 1024.0f / 1024.0f;
        String strVal = String.format("%.1fM", fVal);
        UpdateProgress(strVal);
    }

    private void UpdateProgress(final String szMsg)
    {
        Runnable runnable_update = new Runnable() {
            @Override
            public void run() {
                dialog.setMessage(szMsg);
            }
        };

        runOnUiThread(runnable_update);
    }

    private Runnable runnable_showProgress = new Runnable() {
        @Override
        public void run() {
            showProgress();
        }
    };

    private Runnable runnable_hideProgress = new Runnable() {
        @Override
        public void run() {
            showProgress();
        }
    };

    public void showProgress()
    {
        if (dialog == null)
        {
            dialog = new ProgressDialog(MainMenuActivity.this);
            dialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
            dialog.setMessage(getResources().getString(R.string.waiting));
            dialog.setCancelable(false);
        }

        if (dialog.isShowing())
            return;

        dialog.show();
    }

    public void hideProgress()
    {
        if (dialog != null)
            dialog.dismiss();
    }

    Runnable runnable_finish_download = new Runnable()
    {
        public void run()
        {
            GlobalData.setMainMenuImgPath(MainMenuActivity.this, upgrade_url);
            GlobalData.setLocalMainMenuImgPath(MainMenuActivity.this, local_file_path);
            try {
                Uri imgPath = Uri.parse(GlobalData.getLocalMainMenuImgPath(MainMenuActivity.this));
                imgBack.setImageURI(imgPath);
            }
            catch (Exception ex)
            {
                imgBack.setImageResource(R.drawable.defbackimage);
            }

            hideProgress();
        }
    };

    Runnable runnable_download_error = new Runnable() {
        @Override
        public void run() {
            GlobalData.showToast(MainMenuActivity.this, getResources().getString(R.string.download_fail));
            hideProgress();
            if (GlobalData.getMainMenuImgPath(MainMenuActivity.this).length() == 0)
            {
                imgBack.setImageResource(R.drawable.defbackimage);
            }
            else
            {
                try {
                    Uri MainMenuPath = Uri.parse(GlobalData.getLocalMainMenuImgPath(MainMenuActivity.this));
                    imgBack.setImageURI(MainMenuPath);
                }
                catch (Exception ex)
                {
                    imgBack.setImageResource(R.drawable.defbackimage);
                }
            }
        }
    };
}
