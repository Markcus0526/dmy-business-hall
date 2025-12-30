package com.damytech.Utils;

import android.content.Context;
import android.content.SharedPreferences;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.view.View;
import android.widget.Toast;

public class GlobalData
{
    public static final String SharedPreferenceName = "ChangLiang";
    public static final String SP_FirstLogin = "FirstLogin";
    public static final String SP_USERID = "UserId";
    public static final String SP_BRANDID = "BrandId";
    public static final String SP_SPECID = "SpecId";
    public static final String SP_COMPANYNAME = "CompanyName";
    public static final String SP_TEMPID = "TempID";
    public static final String SP_SNCODE = "SNCode";
    public static final String SP_VIDEOPATH = "VideoPath";
    public static final String SP_LOCALVIDEOPATH = "LocalVideoPath";
    public static final String SP_SPLASHIMGPATH = "SplashImg";
    public static final String SP_LOCALSPLASHIMGPATH = "LocalSplashImg";
    public static final String SP_MAINMENUIMGPATH = "MainMenuImg";
    public static final String SP_LOCALMAINMENUIMGPATH = "LocalMainMenuImg";
    public static final String SP_FEATUREIMGCOUNT = "FeatureImgCount";
    public static final String SP_FEATUREIMGPATH = "FeatureImg";
    public static final String SP_LOCALFEATUREIMGPATH = "LocalFeatureImg";
    public static final String SP_STATIIMGCOUNT = "StatiImgCount";
    public static final String SP_STATIIMGPATH = "StatiImg";
    public static final String SP_LOCALSTATIIMGPATH = "LocalStatiImg";

	private static Toast g_Toast = null;
	public static void showToast(Context context, String toastStr)
	{
		if ((g_Toast == null) || (g_Toast.getView().getWindowVisibility() != View.VISIBLE))
		{
			g_Toast = Toast.makeText(context, toastStr, Toast.LENGTH_SHORT);
			g_Toast.show();
		}

		return;
	}

    public static boolean isOnline(Context ctx)
    {
        ConnectivityManager cm = (ConnectivityManager) ctx.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        if (netInfo != null && netInfo.isConnectedOrConnecting()) {
            return true;
        }
        return false;
    }

    public static void setFirstLogin(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(GlobalData.SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putInt(GlobalData.SP_FirstLogin, 0);
        editor.commit();
    }

    public static int getFirstLogin(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(GlobalData.SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getInt(GlobalData.SP_FirstLogin, 1);
    }

    public static void setUserID(Context ctx, long userid)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(SP_USERID, userid);
        editor.commit();
    }

    public static long getUserID(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(SP_USERID, 0);
    }

    public static void setBrandID(Context ctx, long brandid)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(SP_BRANDID, brandid);
        editor.commit();
    }

    public static long getBrandID(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(SP_BRANDID, 0);
    }

    public static void setSpecID(Context ctx, long specid)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(SP_SPECID, specid);
        editor.commit();
    }

    public static long getSpecID(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(SP_SPECID, 0);
    }

    public static void setCompanyName(Context ctx, String title)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_COMPANYNAME, title);
        editor.commit();
    }

    public static String getCompanyName(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_COMPANYNAME, "");
    }
    
    public static void setTempID(Context ctx, long tempid)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(SP_TEMPID, tempid);
        editor.commit();
    }

    public static long getTempID(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(SP_TEMPID, 1);
    }

    public static void setVideoPath(Context ctx, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_VIDEOPATH, videoPath);
        editor.commit();
    }

    public static String getVideoPath(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_VIDEOPATH, "");
    }

    public static void setLocalVideoPath(Context ctx, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_LOCALVIDEOPATH, videoPath);
        editor.commit();
    }

    public static String getLocalVideoPath(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_LOCALVIDEOPATH, "");
    }

    public static void setSplashImgPath(Context ctx, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_SPLASHIMGPATH, videoPath);
        editor.commit();
    }

    public static String getSplashImgPath(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_SPLASHIMGPATH, "");
    }

    public static void setLocalSplashImgPath(Context ctx, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_LOCALSPLASHIMGPATH, videoPath);
        editor.commit();
    }

    public static String getLocalSplashImgPath(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_LOCALSPLASHIMGPATH, "");
    }

    public static void setMainMenuImgPath(Context ctx, String videoPath)
{
    SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
    SharedPreferences.Editor editor = pref.edit();
    editor.putString(SP_MAINMENUIMGPATH, videoPath);
    editor.commit();
}

    public static String getMainMenuImgPath(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_MAINMENUIMGPATH, "");
    }

    public static void setLocalMainMenuImgPath(Context ctx, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_LOCALMAINMENUIMGPATH, videoPath);
        editor.commit();
    }

    public static String getLocalMainMenuImgPath(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_LOCALMAINMENUIMGPATH, "");
    }

    public static void setStatiImgCount(Context ctx, long nCount)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(SP_STATIIMGCOUNT, nCount);
        editor.commit();
    }

    public static long getStatiImgCount(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(SP_STATIIMGCOUNT, 0);
    }

    public static void setStatiImgPath(Context ctx, long nNumber, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_STATIIMGPATH + Long.toString(nNumber), videoPath);
        editor.commit();
    }

    public static String getStatiImgPath(Context ctx, long nNumber)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_STATIIMGPATH + Long.toString(nNumber), "");
    }

    public static void setLocalStatiImgPath(Context ctx, long nNumber, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_LOCALSTATIIMGPATH + Long.toString(nNumber), videoPath);
        editor.commit();
    }

    public static String getLocalStatiImgPath(Context ctx, long nNumber)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_LOCALSTATIIMGPATH + Long.toString(nNumber), "");
    }

    public static void setFeatureImgCount(Context ctx, long nCount)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(SP_FEATUREIMGCOUNT, nCount);
        editor.commit();
    }

    public static long getFeatureImgCount(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(SP_FEATUREIMGCOUNT, 0);
    }

    public static void setFeatureImgPath(Context ctx, long nNumber, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_FEATUREIMGPATH + Long.toString(nNumber), videoPath);
        editor.commit();
    }

    public static String getFeatureImgPath(Context ctx, long nNumber)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_FEATUREIMGPATH + Long.toString(nNumber), "");
    }

    public static void setLocalFeatureImgPath(Context ctx, long nNumber, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_LOCALFEATUREIMGPATH + Long.toString(nNumber), videoPath);
        editor.commit();
    }

    public static String getLocalFeatureImgPath(Context ctx, long nNumber)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_LOCALFEATUREIMGPATH + Long.toString(nNumber), "");
    }

    public static void setSNCode(Context ctx, String snCode)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(SP_SNCODE, snCode);
        editor.commit();
    }

    public static String getSNCode(Context ctx)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(SP_SNCODE, "");
    }

    /*
     */
    public static void setImgListCount(Context ctx, long nShopID, long nDetID, long nCount)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putLong(Long.toString(nShopID) + "-" + Long.toString(nDetID) + "-Count", nCount);
        editor.commit();
    }

    public static long getImgListCount(Context ctx, long nShopID, long nDetID)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getLong(Long.toString(nShopID) + "-" + Long.toString(nDetID) + "-Count", 0);
    }

    public static void setImgListPathWithNo(Context ctx, long nShopID, long nDetID, long nNumber, String strPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(Long.toString(nShopID) + "-" + Long.toString(nDetID) + "-" + Long.toString(nNumber), strPath);
        editor.commit();
    }

    public static String getImgListPathWithNo(Context ctx, long nShopID, long nDetID, long nNumber)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(Long.toString(nShopID) + "-" + Long.toString(nDetID) + "-" + Long.toString(nNumber), "");
    }

    public static void setLocalImgListPathWithNo(Context ctx, long nShopID, long nDetID, long nNumber, String videoPath)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(Long.toString(nShopID) + "-" + Long.toString(nDetID) + "-" + Long.toString(nNumber) + "-Local", videoPath);
        editor.commit();
    }

    public static String getLocalImgListPathWithNo(Context ctx, long nShopID, long nDetID, long nNumber)
    {
        SharedPreferences pref = ctx.getSharedPreferences(SharedPreferenceName, Context.MODE_PRIVATE);
        return pref.getString(Long.toString(nShopID) + "-" + Long.toString(nDetID) + "-" + Long.toString(nNumber) + "-Local", "");
    }
    /*
     */

    public static String getCurrentMACAddress(Context ctx)
    {
        String macAddress = "";

        WifiManager wfManager = (WifiManager)ctx.getSystemService(Context.WIFI_SERVICE);
        if (wfManager.isWifiEnabled() == false)
        {
            wfManager.setWifiEnabled(true);
        }

        WifiInfo wfInfo = wfManager.getConnectionInfo();
        macAddress = wfInfo.getMacAddress();

        return macAddress;
    }
}
