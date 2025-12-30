package com.damytech.DianXin;

import android.app.KeyguardManager;
import android.content.Context;

/**
 * Created by RiGS on 14-5-11.
 */
public class ScreenManager
{
    public static KeyguardManager keyguardManager = null;
    public static KeyguardManager.KeyguardLock keyguardLock;

    static
    {
        keyguardLock = null;
    }

    public static void disableKeyguard(Context paramContext)
    {
        init(paramContext);
        try {
            keyguardLock.disableKeyguard();
        } catch (Exception ex) {
        }
    }

    public static void reenableKeyguard()
    {
        try {
            keyguardLock.reenableKeyguard();
        } catch (Exception ex) {
        }
    }

    public static void init(Context paramContext)
    {
        try {
            keyguardManager = (KeyguardManager)paramContext.getSystemService(Context.KEYGUARD_SERVICE);
            keyguardLock = keyguardManager.newKeyguardLock(Context.KEYGUARD_SERVICE);
        } catch (Exception ex) {
        }
    }
}
