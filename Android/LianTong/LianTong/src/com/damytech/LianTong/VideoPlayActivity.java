package com.damytech.LianTong;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Rect;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.VideoView;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.STData.STString;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;
import org.json.JSONObject;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;

public class VideoPlayActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;

    VideoView mVideoView;
    ImageView imgMenu;

    private String upgrade_url = "";
    private String local_file_path = "";

    STString info = new STString();
    long nServiceRet = -1;
    private JsonHttpResponseHandler handlerVideo = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nServiceRet = CommMgr.commService.parsegetVideoPath(response, info);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
        }

        @Override
        public void onFinish() {
            super.onFinish();

            progdialog.dismiss();

            String oldVideoPath = GlobalData.getVideoPath(VideoPlayActivity.this);
            if ( info.data == null || (info.data != null && info.data.length() == 0))
            {
                if (oldVideoPath.length() == 0)
                {
                    Uri video = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.video);
                    mVideoView.setVideoURI(video);
                    mVideoView.start();
                }
                else
                {
                    try {
                        Uri video = Uri.parse(GlobalData.getLocalVideoPath(VideoPlayActivity.this));
                        mVideoView.setVideoURI(video);
                        mVideoView.start();
                    }
                    catch (Exception ex)
                    {
                        Uri video = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.video);
                        mVideoView.setVideoURI(video);
                        mVideoView.start();
                    }
                }
                return;
            }

            if (info.data != null && info.data.length() > 0)
            {
                if (info.data.equals(GlobalData.getVideoPath(VideoPlayActivity.this)) == true)
                {
                    String strLocalVideoPath = GlobalData.getLocalVideoPath(VideoPlayActivity.this);
                    Uri video = Uri.parse(strLocalVideoPath);
                    mVideoView.setVideoURI(video);
                    mVideoView.start();
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
    ProgressDialog progdialog = null;

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_videoplay);

        configWindow();
        setScreenLight();
        initView();

        rlMainBack = (RelativeLayout)findViewById(R.id.rlVideoPlayBack);
        rlMainBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mVideoView != null) {
                    if (mVideoView.isPlaying())
                        mVideoView.pause();
                    mVideoView.stopPlayback();
                }

                Intent intent = new Intent(VideoPlayActivity.this, SplashActivity.class);
                startActivity(intent);
                finish();
            }
        });
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false) {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlVideoPlayBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        progdialog = ProgressDialog.show(
                VideoPlayActivity.this,
                "",
                getString(R.string.waiting),
                true,
                false,
                null);
        CommMgr.commService.getVideoPath(handlerVideo,
                Long.toString(GlobalData.getUserID(VideoPlayActivity.this)),
                Long.toString(GlobalData.getBrandID(VideoPlayActivity.this)),
                Long.toString(GlobalData.getSpecID(VideoPlayActivity.this)));
    }

    @Override
    public void onStart()
    {
        super.onStart();
    }

    public void initView()
    {
        imgMenu = (ImageView) findViewById(R.id.imgPlayVideoMenu);
        imgMenu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                GlobalData.showToast(VideoPlayActivity.this, "Menu Button Clicked!");
            }
        });

        mVideoView = (VideoView) findViewById(R.id.videoPlayVideo);
        mVideoView.setOnPreparedListener(new MediaPlayer.OnPreparedListener() {
            @Override
            public void onPrepared(MediaPlayer mp) {
                mp.setLooping(true);
            }
        });
        mVideoView.setOnErrorListener(new MediaPlayer.OnErrorListener() {
            @Override
            public boolean onError(MediaPlayer mp, int what, int extra) {
                GlobalData.showToast(VideoPlayActivity.this, getString(R.string.VideoFile_Error));
                VideoPlayActivity.this.finish();
                return false;
            }
        });
        mVideoView.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
            @Override
            public void onCompletion(MediaPlayer mp) {

            }
        });
        mVideoView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mVideoView != null)
                {
                    if (mVideoView.isPlaying())
                        mVideoView.pause();
                    mVideoView.stopPlayback();
                }

                Intent intent = new Intent(VideoPlayActivity.this, MainActivity.class);
                startActivity(intent);
                finish();
            }
        });
    }

    @Override
    public void onPause()
    {
        super.onPause();
        if (mVideoView != null)
        {
            if (mVideoView.isPlaying())
                mVideoView.pause();
        }
    }

    @Override
    public void onDestroy()
    {
        super.onDestroy();
        if (mVideoView != null)
            mVideoView.stopPlayback();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event)
    {
        if (keyCode == event.KEYCODE_BACK)
        {
            if (mVideoView != null)
            {
                if (mVideoView.isPlaying())
                    mVideoView.pause();
                mVideoView.stopPlayback();
            }

            Intent intent = new Intent(VideoPlayActivity.this, SplashActivity.class);
            startActivity(intent);
            finish();
        }

        return super.onKeyDown(keyCode, event);
    }

    public void setScreenLight()
    {
        if (getSharedPreferences("settingInfo", 0).getString("switch_light", "1").equals("1"))
        {
            Settings.System.putInt(getContentResolver(),Settings.System.SCREEN_BRIGHTNESS_MODE, Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL);
            Settings.System.putInt(getContentResolver(), Settings.System.SCREEN_BRIGHTNESS, 255);

            return;
        }

        Settings.System.putInt(getContentResolver(),Settings.System.SCREEN_BRIGHTNESS_MODE, Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL);
        Settings.System.putInt(getContentResolver(), Settings.System.SCREEN_BRIGHTNESS, 120);
    }

    public void configWindow()
    {
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_BLUR_BEHIND, WindowManager.LayoutParams.FLAG_BLUR_BEHIND);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON);

        WindowManager.LayoutParams localLayoutParams = getWindow().getAttributes();
        localLayoutParams.screenBrightness = 1.0F;
        getWindow().setAttributes(localLayoutParams);
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
            dialog = new ProgressDialog(VideoPlayActivity.this);
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
            GlobalData.setVideoPath(VideoPlayActivity.this, upgrade_url);
            GlobalData.setLocalVideoPath(VideoPlayActivity.this, local_file_path);
            try {
                Uri video = Uri.parse(GlobalData.getLocalVideoPath(VideoPlayActivity.this));
                mVideoView.setVideoURI(video);
                mVideoView.start();
            }
            catch (Exception ex)
            {
                Uri video = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.video);
                mVideoView.setVideoURI(video);
                mVideoView.start();
            }

            hideProgress();
        }
    };

    Runnable runnable_download_error = new Runnable() {
        @Override
        public void run() {
            GlobalData.showToast(VideoPlayActivity.this, getResources().getString(R.string.download_fail));
            hideProgress();
            if (GlobalData.getVideoPath(VideoPlayActivity.this).length() == 0)
            {
                Uri video = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.video);
                mVideoView.setVideoURI(video);
                mVideoView.start();
            }
            else
            {
                try {
                    Uri video = Uri.parse(GlobalData.getLocalVideoPath(VideoPlayActivity.this));
                    mVideoView.setVideoURI(video);
                    mVideoView.start();
                }
                catch (Exception ex)
                {
                    Uri video = Uri.parse("android.resource://" + getPackageName() + "/" + R.raw.video);
                    mVideoView.setVideoURI(video);
                    mVideoView.start();
                }
            }
        }
    };
}
