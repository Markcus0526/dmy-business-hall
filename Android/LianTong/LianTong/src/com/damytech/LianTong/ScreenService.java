package com.damytech.LianTong;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.IBinder;

/**
 * Created by RiGS on 14-5-11.
 */
public class ScreenService extends Service
{
    private ScreenReceiver mScreenOffReceiver = null;

    @Override
    public void onCreate()
    {
        super.onCreate();

        ScreenManager.disableKeyguard(this);

        generateNotification();
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int paramInt1, int paramInt2)
    {
        IntentFilter intentFilter = new IntentFilter(Intent.ACTION_SCREEN_OFF);
        intentFilter.setPriority(1000);
        mScreenOffReceiver = new ScreenReceiver();
        registerReceiver(mScreenOffReceiver, intentFilter);

        return super.onStartCommand(intent, paramInt1, paramInt2);
    }

    @Override
    public void onDestroy()
    {
        ScreenManager.reenableKeyguard();
        unregisterReceiver(mScreenOffReceiver);
        startService(new Intent(this, ScreenService.class));

        super.onDestroy();
    }

    public void generateNotification()
    {
        long when = System.currentTimeMillis();
        NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

        Notification notification = new Notification(getResources().getIdentifier("ic_launcher", "drawable", getPackageName()), getString(R.string.NotificationTitle), when);
        notification.flags = 32;
        notification.flags = 2;

        Context context = getApplicationContext();
        Intent notificationIntent = new Intent(context, MainMenuActivity.class);
        notification.setLatestEventInfo(context, getString(R.string.NotificationTitle), getString(R.string.NotificationData), PendingIntent.getActivity(this, 0, notificationIntent, 0));
        notificationManager.notify(1, notification);
    }
}
