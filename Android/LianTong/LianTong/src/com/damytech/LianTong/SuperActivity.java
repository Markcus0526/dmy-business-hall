package com.damytech.LianTong;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;

public class SuperActivity extends Activity {
    final int VIDEOPLAY_TIMEOUT = 5 * 1000;

    private Handler handler = new Handler()
    {
        @Override
        public void handleMessage(Message msg)
        {
        }
    };

    private Runnable videoCallback = new Runnable() {
        @Override
        public void run() {
            Intent intent = new Intent(SuperActivity.this, LogoActivity.class);
            startActivity(intent);
            finish();
        }
    };

    public void resetVideoTimer(){
        handler.removeCallbacks(videoCallback);
        handler.postDelayed(videoCallback, VIDEOPLAY_TIMEOUT);
    }

    public void stopVideoTimer(){
        handler.removeCallbacks(videoCallback);
    }

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onUserInteraction()
    {
        super.onUserInteraction();
        resetVideoTimer();
    }

    @Override
    public void onResume() {
        super.onResume();
        resetVideoTimer();
    }

    @Override
    public void onStop() {
        super.onStop();
        stopVideoTimer();
    }
}