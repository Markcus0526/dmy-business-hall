package com.damytech.DianXin;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.graphics.Rect;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.RelativeLayout;
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

public class SplashActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;
    SmartImageView imgBack = null;

    STString info = new STString();
    long nServiceRet = -1;

    private String upgrade_url = "";
    private String local_file_path = "";

    private JsonHttpResponseHandler handlerSplash = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nServiceRet = CommMgr.commService.parsegetSplashImgPath(response, info);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
        }

        @Override
        public void onFinish() {
            super.onFinish();

            dialog.dismiss();
            String oldSplashPath = GlobalData.getSplashImgPath(SplashActivity.this);
            if ( info.data == null || (info.data != null && info.data.length() == 0))
            {
                if (oldSplashPath.length() == 0)
                {
                    imgBack.setImageResource(R.drawable.defbackimage);
                }
                else
                {
                    try {
                        Uri imgPath = Uri.parse(GlobalData.getLocalSplashImgPath(SplashActivity.this));
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
                if (info.data.equals(GlobalData.getSplashImgPath(SplashActivity.this)) == true)
                {
                    String strLocalSplashPath = GlobalData.getLocalSplashImgPath(SplashActivity.this);
                    Uri imgPath = Uri.parse(strLocalSplashPath);
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
    private JsonHttpResponseHandler handlerTempID = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            long nRet = CommMgr.commService.parsegetTemplateID(response);
            GlobalData.setTempID(SplashActivity.this, nRet);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
        }

        @Override
        public void onFinish() {
            super.onFinish();
        }
    };
    ProgressDialog dialog = null;

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlSplashBack);
        rlMainBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(SplashActivity.this, MainMenuActivity.class));
                SplashActivity.this.finish();
            }
        });
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlSplashBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        imgBack = (SmartImageView) findViewById(R.id.imgSplash_Back);

        dialog = ProgressDialog.show(
                SplashActivity.this,
                "",
                getString(R.string.waiting),
                true,
                false,
                null);
        CommMgr.commService.getSplashImgPath(handlerSplash,
                Long.toString(GlobalData.getUserID(SplashActivity.this)),
                Long.toString(GlobalData.getBrandID(SplashActivity.this)),
                Long.toString(GlobalData.getSpecID(SplashActivity.this)));
        CommMgr.commService.getTemplateID(handlerTempID,
                Long.toString(GlobalData.getUserID(SplashActivity.this)));
    }

    @Override
    public void onResume()
    {
        super.onResume();
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
            dialog = new ProgressDialog(SplashActivity.this);
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
            GlobalData.setSplashImgPath(SplashActivity.this, upgrade_url);
            GlobalData.setLocalSplashImgPath(SplashActivity.this, local_file_path);
            try {
                Uri imgPath = Uri.parse(GlobalData.getLocalSplashImgPath(SplashActivity.this));
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
            GlobalData.showToast(SplashActivity.this, getResources().getString(R.string.download_fail));
            hideProgress();
            if (GlobalData.getSplashImgPath(SplashActivity.this).length() == 0)
            {
                imgBack.setImageResource(R.drawable.defbackimage);
            }
            else
            {
                try {
                    Uri splashPath = Uri.parse(GlobalData.getLocalSplashImgPath(SplashActivity.this));
                    imgBack.setImageURI(splashPath);
                }
                catch (Exception ex)
                {
                    imgBack.setImageResource(R.drawable.defbackimage);
                }
            }
        }
    };
}
