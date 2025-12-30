package com.damytech.DianXinPerson;

import android.app.*;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Point;
import android.view.KeyEvent;
import com.damytech.Misc.Global;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: KHM
 * Date: 14-2-1
 * Time: 下午3:15
 * To change this template use File | Settings | File Templates.
 */
public class SuperActivity extends Activity {
	public ProgressDialog m_dlgProg = null;
	public AlertDialog.Builder m_pAlertDlg = null;

	private String m_szVersion = "";
	private String m_szUrl = "";
	private String m_szLocalPath = "";

	@Override
	protected void onResume() {
		super.onResume();    //To change body of overridden methods use File | Settings | File Templates.

		int nDir = getIntent().getIntExtra("anim_direction", -1);
		if (nDir == Global.LEFT_ANIM())
			overridePendingTransition(R.anim.left_in, R.anim.right_out);
		else if (nDir == Global.RIGHT_ANIM())
			overridePendingTransition(R.anim.right_in, R.anim.left_out);
		else
			overridePendingTransition(0, 0);
	}

	@Override
	protected void onPause() {
		super.onPause();    //To change body of overridden methods use File | Settings | File Templates.

		if (getIntent().getExtras() != null)
			getIntent().getExtras().clear();
	}

	@Override
	protected void onNewIntent(Intent intent) {
		super.setIntent(intent);    //To change body of overridden methods use File | Settings | File Templates.
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event)
	{
		if (keyCode == KeyEvent.KEYCODE_BACK)
		{
			if (isLastActivity())
			{
				try
				{
					showQuitDialog();
				}
				catch (Exception ex)
				{
					ex.printStackTrace();
				}
			}
			else
			{
				finishWithAnimation();
			}

			return true;
		}

		return super.onKeyDown(keyCode, event);
	}

	public void showQuitDialog()
	{
		m_pAlertDlg = new AlertDialog.Builder(SuperActivity.this);
		m_pAlertDlg.setMessage(R.string.STR_CONFIRM_EXIT);
		m_pAlertDlg.setPositiveButton(R.string.STR_OK, onClickOK);
		m_pAlertDlg.setNegativeButton(R.string.STR_CANCEL, new DialogInterface.OnClickListener()
		{
			@Override
			public void onClick(DialogInterface dialog, int which)
			{
				m_pAlertDlg = null;
			}
		});

		m_pAlertDlg.show();
	}

	public boolean isLastActivity()
	{
		ActivityManager mngr = (ActivityManager)getSystemService(ACTIVITY_SERVICE);
		List<ActivityManager.RunningTaskInfo> taskList = mngr.getRunningTasks(10);

		if (taskList.get(0).numActivities != 1 || !taskList.get(0).topActivity.getClassName().equals(this.getClass().getName()))
			return false;

		return true;
	}

	private DialogInterface.OnClickListener onClickOK = new DialogInterface.OnClickListener() {
		@Override
		public void onClick(DialogInterface dialog, int which)
		{
			m_pAlertDlg = null;
			moveTaskToBack(true);
			SuperActivity.this.finish();
			System.exit(0);
		}
	};

	private DialogInterface.OnClickListener onClickNo = new DialogInterface.OnClickListener() {
		@Override
		public void onClick(DialogInterface dialog, int which)
		{
			//To change body of implemented methods use File | Settings | File Templates.
			m_pAlertDlg = null;
		}
	};

	public void startProgress()
	{
		startProgress(getResources().getString(R.string.STR_PLEASE_WAIT));
	}

	public void startProgress(String szMsg)
	{
		if (m_dlgProg != null && m_dlgProg.isShowing())
			return;

		if (m_dlgProg == null)
		{
			m_dlgProg = new ProgressDialog(SuperActivity.this);
			m_dlgProg.setMessage(szMsg);
			m_dlgProg.setCancelable(true);
		}

		m_dlgProg.show();
	}

	public void stopProgress()
	{
		if (m_dlgProg != null)
		{
			m_dlgProg.dismiss();
			m_dlgProg = null;
		}
	}

	public void finishWithAnimation()
	{
		SuperActivity.this.finish();
		int nDir = SuperActivity.this.getIntent().getIntExtra("anim_direction", -1);
		if (nDir == Global.RIGHT_ANIM())
			SuperActivity.this.overridePendingTransition(R.anim.left_in, R.anim.right_out);
		else
			SuperActivity.this.overridePendingTransition(R.anim.right_in, R.anim.left_out);
	}

	public Point mScrSize = new Point(0, 0);
	public Point getScreenSize()
	{
		Point ptTemp = Global.getScreenSize(getApplicationContext());
		ptTemp.y -= Global.statusBarHeight(this);

		return ptTemp;
	}
}
