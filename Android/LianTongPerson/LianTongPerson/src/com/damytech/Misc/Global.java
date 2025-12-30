package com.damytech.Misc;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.graphics.*;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.util.Log;
import android.view.*;
import android.view.inputmethod.InputMethodManager;
import android.widget.*;
import com.damytech.Utils.ResolutionSet;
import java.io.File;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-1-9
 * Time: 上午1:00
 * To change this template use File | Settings | File Templates.
 */

public class Global
{
	public static int LEFT_ANIM() { return 0; }
	public static int RIGHT_ANIM() { return 1; }

	public static Toast gToast = null;

	public static void showToast(Activity activity, String toastStr)
	{
		if (gToast == null || gToast.getView().getWindowVisibility() != View.VISIBLE)
		{
			gToast = Toast.makeText(activity, toastStr, Toast.LENGTH_SHORT);

			Point ptSize = Global.getScreenSize(activity);
			ptSize.y -= statusBarHeight(activity);
			ResolutionSet.instance.iterateChild(gToast.getView(), ptSize.x, ptSize.y);
			gToast.show();
		}
	}

	public static void showToastWithActivity(Activity activity, View view, int gravity)
	{
		if (gToast != null)
			gToast.cancel();

		gToast = new Toast(activity);
		gToast.setView(view);

		Point ptSize = getScreenSize(activity);
		ptSize.y -= statusBarHeight(activity);
		ResolutionSet.instance.iterateChild(view, ptSize.x, ptSize.y);

		gToast.setDuration(Toast.LENGTH_SHORT);
		if ((gravity & Gravity.BOTTOM) == Gravity.BOTTOM)
			gToast.setGravity(gravity, 0, ptSize.y * 1 / 5);
		else
			gToast.setGravity(gravity, 0, 0);
		gToast.show();
	}

	public static boolean isExternalStorageRemovable()
	{
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.GINGERBREAD)
		{
			return Environment.isExternalStorageRemovable();
		}

		return true;
	}

	public static File getExternalCacheDir(Context context) {
		if (hasExternalCacheDir()) {
			return context.getExternalCacheDir();
		}

		// Before Froyo we need to construct the external cache dir ourselves
		final String cacheDir = "/Android/data/" + context.getPackageName() + "/cache/";
		return new File(Environment.getExternalStorageDirectory().getPath() + cacheDir);
	}

	public static boolean hasExternalCacheDir()
	{
		return Build.VERSION.SDK_INT >= Build.VERSION_CODES.FROYO;
	}

	public static void logMessage(String szMsg)
	{
		Log.d("Investor", szMsg);
	}

	public static String eatSpaces(String szText)
	{
		return szText.replaceAll(" ", "");
	}

	public static String eatChinesePunctuations(String szText)
	{
		String szResult = szText;
		String szPuncs = "。？！，、；：“”‘’（）-·《》〈〉";
		String szPuncs2 = "——";
		String szPuncs3 = "……";

		szResult = szResult.replaceAll(szPuncs2, "");
		szResult = szResult.replaceAll(szPuncs3, "");
		for (int i = 0; i < szPuncs.length(); i++)
		{
			char chrItem = szPuncs.charAt(i);
			String szItem = "" + chrItem;
			szResult = szResult.replaceAll(szItem, "");
		}

		return szResult;
	}

	public static Point getScreenSize(Context appContext)
	{
		Point ptSize = new Point(0, 0);

		WindowManager wm = (WindowManager)appContext.getSystemService(Context.WINDOW_SERVICE);
		Display display = wm.getDefaultDisplay();
		display.getSize(ptSize);

		return ptSize;
	}

	public static String getCurDateString(Calendar calendar)
	{
		int nYear = calendar.get(Calendar.YEAR);
		int nMonth = calendar.get(Calendar.MONTH) + 1;
		int nDay = calendar.get(Calendar.DAY_OF_MONTH);

		return String.format("%d-%02d-%02d", nYear, nMonth, nDay);
	}

	public static void callPhone(String szPhoneNum, Context context)
	{
		Intent intent = new Intent(Intent.ACTION_CALL);
		intent.setData(Uri.parse("tel:" + szPhoneNum));
		context.startActivity(intent);
	}

	public static int getSystemVersion(Context appContext)
	{
		int nVersion = 0;
		try
		{
			PackageInfo pInfo = appContext.getPackageManager().getPackageInfo(appContext.getPackageName(), 0);
			nVersion = pInfo.versionCode;
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			nVersion = -1;
		}

		return nVersion;
	}

	public static String getVersionName(Context appContext)
	{
		String szPack = "";

		try
		{
			PackageInfo pInfo = appContext.getPackageManager().getPackageInfo(appContext.getPackageName(), 0);
			szPack = pInfo.versionName;
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			szPack = "";
		}

		return szPack;
	}

	public static Bitmap getRoundedCornerBitmap(Bitmap bitmap, int pixels)
	{
		Bitmap output = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), Bitmap.Config.ARGB_8888);
		Canvas canvas = new Canvas(output);

		final int color = 0xff424242;
		final Paint paint = new Paint();
		final Rect rect = new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
		final RectF rectF = new RectF(rect);
		final float roundPx = pixels;

		paint.setAntiAlias(true);
		canvas.drawARGB(0, 0, 0, 0);
		paint.setColor(color);
		canvas.drawRoundRect(rectF, roundPx, roundPx, paint);

		paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
		canvas.drawBitmap(bitmap, rect, rect, paint);

		return output;
	}

	public static boolean IsNight()
	{
		boolean bResult = false;

		Calendar calendar = Calendar.getInstance();
		int nHour = calendar.get(Calendar.HOUR_OF_DAY);
		bResult = (nHour >= 5 && nHour <=18);

		return !bResult;
	}

	public static String getBaiduKey() { return "A737CDFA6D523EC18453F98BB399A8E04D9C51C8"; }

	public static void showKeyboardFromText(EditText editText, Context context)
	{
		InputMethodManager mgr = (InputMethodManager)context.getSystemService(Context.INPUT_METHOD_SERVICE);
		mgr.showSoftInput(editText, InputMethodManager.SHOW_IMPLICIT);
	}

	public static void hideKeyboardFromText(EditText editText, Context context)
	{
		InputMethodManager mgr = (InputMethodManager)context.getSystemService(Context.INPUT_METHOD_SERVICE);
		mgr.hideSoftInputFromWindow(editText.getWindowToken(), 0);
	}

	public static int statusBarHeight(Activity activity) {
		Rect rectgle= new Rect();
		Window window= activity.getWindow();
		window.getDecorView().getWindowVisibleDisplayFrame(rectgle);
		int statusBar = rectgle.top;
		return statusBar;
	}

	public static boolean isEmailValid(String email) {
		boolean isValid = false;

		String expression = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
		CharSequence inputStr = email;

		Pattern pattern = Pattern.compile(expression, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(inputStr);
		if (matcher.matches())
			isValid = true;

		return isValid;
	}

	public static int getApiVersion()
	{
		return Build.VERSION.SDK_INT;
	}
}
