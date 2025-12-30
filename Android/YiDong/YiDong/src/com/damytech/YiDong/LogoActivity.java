package com.damytech.YiDong;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.ViewTreeObserver;
import android.widget.RelativeLayout;
import com.damytech.Utils.ResolutionSet;

public class LogoActivity extends Activity {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;

    Handler handler= new Handler() {
        public void handleMessage(Message msg){
            startActivity(new Intent(LogoActivity.this, VideoPlayActivity.class));
            LogoActivity.this.finish();
        }
    };
    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_logo);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlLogoBack);
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlLogoBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        handler.sendEmptyMessageDelayed(0, 2000);
    }
}
