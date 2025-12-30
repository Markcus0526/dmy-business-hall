package com.damytech.LianTong;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

public class ScreenReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent paramIntent)
    {
        if (paramIntent.getAction().equals(Intent.ACTION_SCREEN_OFF) || paramIntent.getAction().equals(Intent.ACTION_SCREEN_ON))
        {
            try {
                Intent intent = new Intent(context, VideoPlayActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(intent);
            } catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }
}
