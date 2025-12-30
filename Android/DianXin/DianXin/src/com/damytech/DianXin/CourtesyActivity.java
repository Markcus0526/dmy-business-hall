package com.damytech.DianXin;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.graphics.Rect;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.view.animation.RotateAnimation;
import android.widget.*;
import com.damytech.CommService.CommMgr;
import com.damytech.HttpConn.JsonHttpResponseHandler;
import com.damytech.STData.STGiftList;
import com.damytech.STData.STSNCode;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;
import org.json.JSONObject;
import java.util.Random;

public class CourtesyActivity extends Activity implements DialogInterface.OnDismissListener {
    boolean bInitialized = false;
    RelativeLayout rlMainBack;
    Button btnStart;
    ImageView imgBackFrame;
    EditText txtItem;
    EditText txtPassword;
    Button btnSend;

    long nSelValue = 0;

    STSNCode snCode = new STSNCode();
    Animation animation = null;

    ConfirmPwdDialog dlg = null;

    long nServiceRet = -1;
    STGiftList giftInfo = new STGiftList();
    private JsonHttpResponseHandler handlerGift = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nServiceRet = CommMgr.commService.parsegetGiftList(response, giftInfo);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
            progDialog.dismiss();
        }

        @Override
        public void onFinish() {
            super.onFinish();

            progDialog.dismiss();
            if (nServiceRet == 0)
            {
                if (giftInfo != null)
                {
                    txtItem.setText( getString(R.string.oneitem) + " " + giftInfo.onegift + "\n"
                                    + getString(R.string.twoitem) + " " + giftInfo.twogift + "\n"
                                    + getString(R.string.threeitem) + " " + giftInfo.threegift + "\n"
                                    + getString(R.string.fouritem) + " " + giftInfo.fourgift + "\n"
                                    + getString(R.string.fiveitem) + " " + giftInfo.fivegift + "\n"
                                    + getString(R.string.sixitem) + " " + giftInfo.sixgift);

                    if (giftInfo.isused == 0)
                    {
                        btnStart.setVisibility(View.VISIBLE);
                        btnSend.setVisibility(View.INVISIBLE);
                        txtPassword.setVisibility(View.INVISIBLE);
                    }
                    else if (giftInfo.isused == 1)
                    {
                        btnStart.setVisibility(View.INVISIBLE);
                        btnSend.setVisibility(View.VISIBLE);
                        txtPassword.setVisibility(View.VISIBLE);
                    }
                    else
                    {
                        btnStart.setVisibility(View.INVISIBLE);
                        btnSend.setVisibility(View.INVISIBLE);
                        txtPassword.setVisibility(View.INVISIBLE);
                    }
                }
                else
                {
                    txtItem.setText("");
                    btnStart.setVisibility(View.INVISIBLE);
                    btnSend.setVisibility(View.INVISIBLE);
                    txtPassword.setVisibility(View.INVISIBLE);
                }
            }
            else
            {
                GlobalData.showToast(CourtesyActivity.this, getString(R.string.network_error));
                finish();
            }
        }
    };
    private JsonHttpResponseHandler handlerSNCode = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nServiceRet = CommMgr.commService.parsegetSNCode(response, snCode);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
            progDialog.dismiss();
        }

        @Override
        public void onFinish() {
            super.onFinish();

            if (nServiceRet == 0)
            {
                imgBackFrame.clearAnimation();
                if (snCode.rank == -1)
                {
                    nSelValue = 0;
                    Random random = new Random();
                    int nDegree = random.nextInt(6) % 6;
                    animation = new RotateAnimation(0f, (1800 + 360 / (12 * 2) + (5-nDegree)*60), Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);
                    animation.setDuration(5000);               // duration in ms
                    animation.setRepeatCount(0);                // -1 = infinite repeated
                    animation.setRepeatMode(Animation.REVERSE); // reverses each repeat
                    animation.setFillAfter(true);               // keep rotation after animation
                    animation.setInterpolator(AnimationUtils.loadInterpolator(CourtesyActivity.this, android.R.anim.decelerate_interpolator));

                    imgBackFrame.setAnimation(animation);
                    imgBackFrame.startAnimation(animation);
                    //GlobalData.showToast(CourtesyActivity.this, Long.toString(nSelValue));
                }
                else if (snCode.rank == -2)
                {
                    nSelValue = 0;
                    Random random = new Random();
                    int nDegree = random.nextInt(6) % 6;
                    animation = new RotateAnimation(0f, (1800 + 360 / (12 * 2) + (5-nDegree)*60), Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);
                    animation.setDuration(5000);               // duration in ms
                    animation.setRepeatCount(0);                // -1 = infinite repeated
                    animation.setRepeatMode(Animation.REVERSE); // reverses each repeat
                    animation.setFillAfter(true);               // keep rotation after animation
                    animation.setInterpolator(AnimationUtils.loadInterpolator(CourtesyActivity.this, android.R.anim.decelerate_interpolator));
                    animation.setAnimationListener(new Animation.AnimationListener() {
                        @Override
                        public void onAnimationStart(Animation animation) {}
                        @Override
                        public void onAnimationRepeat(Animation animation) {}

                        @Override
                        public void onAnimationEnd(Animation animation) {
                            btnStart.setVisibility(View.VISIBLE);
                        }
                    });

                    imgBackFrame.setAnimation(animation);
                    imgBackFrame.startAnimation(animation);
                    //GlobalData.showToast(CourtesyActivity.this, Long.toString(nSelValue));
                }
                else
                {
                    nSelValue = snCode.rank;
                    animation = new RotateAnimation(0f, (int)(1800 + 360 / (12 * 2) + (5-snCode.rank)*60+30), Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);
                    animation.setDuration(5000);               // duration in ms
                    animation.setRepeatCount(0);                // -1 = infinite repeated
                    animation.setRepeatMode(Animation.REVERSE); // reverses each repeat
                    animation.setFillAfter(true);               // keep rotation after animation
                    animation.setInterpolator(AnimationUtils.loadInterpolator(CourtesyActivity.this, android.R.anim.decelerate_interpolator));

                    animation.setAnimationListener(new Animation.AnimationListener() {
                        @Override
                        public void onAnimationStart(Animation animation) {}
                        @Override
                        public void onAnimationRepeat(Animation animation) {}
                        @Override
                        public void onAnimationEnd(Animation animation) {
                            btnStart.setVisibility(View.GONE);
                            txtPassword.setVisibility(View.VISIBLE);
                            btnSend.setVisibility(View.VISIBLE);
                        }
                    });

                    imgBackFrame.setAnimation(animation);
                    imgBackFrame.startAnimation(animation);
                    //GlobalData.showToast(CourtesyActivity.this, Long.toString(nSelValue+1));

                    GlobalData.setSNCode(CourtesyActivity.this, snCode.snnum);
                }
            }
            else
            {
                GlobalData.showToast(CourtesyActivity.this, getString(R.string.service_error));
                return;
            }
        }
    };
    private JsonHttpResponseHandler handlerReqGift = new JsonHttpResponseHandler()
    {
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nServiceRet = CommMgr.commService.parsegetReqGift(response);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
            progDialog.dismiss();
        }

        @Override
        public void onFinish() {
            super.onFinish();

            progDialog.dismiss();
            if (nServiceRet == 0)
            {
                GlobalData.showToast(CourtesyActivity.this, getString(R.string.gift_success));
                btnStart.setVisibility(View.INVISIBLE);
                btnSend.setVisibility(View.INVISIBLE);
                txtPassword.setVisibility(View.INVISIBLE);
            }
            else
            {
                GlobalData.showToast(CourtesyActivity.this, getString(R.string.gift_fail));
                btnStart.setVisibility(View.INVISIBLE);
                btnSend.setVisibility(View.VISIBLE);
                txtPassword.setVisibility(View.VISIBLE);
            }
            return;
        }
    };
    private JsonHttpResponseHandler handlerCheckGiftPass = new JsonHttpResponseHandler()
    {
        long nRet = -1;
        @Override
        public void onSuccess(JSONObject response) {
            super.onSuccess(response);

            nRet = CommMgr.commService.parsecheckGiftPass(response);
        }

        @Override
        public void onFailure(Throwable e, JSONObject errorResponse) {
            super.onFailure(e, errorResponse);
            progDialog.dismiss();
        }

        @Override
        public void onFinish() {
            super.onFinish();

            progDialog.dismiss();
            if (nRet < 0)
            {
                GlobalData.showToast(CourtesyActivity.this, getString(R.string.passwrd_notmatch));

                return;
            }
            else if (nRet == 1)
            {
                String strMACAddr =  GlobalData.getCurrentMACAddress(CourtesyActivity.this);
                if (strMACAddr == null || strMACAddr.length() == 0)
                {
                    GlobalData.showToast(CourtesyActivity.this, getString(R.string.service_error));
                    return;
                }

                Random random = new Random();
                int nDegree = random.nextInt(6) % 6;
                animation = new RotateAnimation(0f, (int)(3600 + 360 / (12 * 2) + (5-nDegree)*60), Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF, 0.5f);

                // Set the animation's parameters
                animation.setDuration(10000);               // duration in ms
                animation.setRepeatCount(0);                // -1 = infinite repeated
                animation.setRepeatMode(Animation.REVERSE); // reverses each repeat
                animation.setFillAfter(true);               // keep rotation after animation
                animation.setInterpolator(AnimationUtils.loadInterpolator(CourtesyActivity.this, android.R.anim.linear_interpolator));

                imgBackFrame.setAnimation(animation);
                imgBackFrame.startAnimation(animation);

                CommMgr.commService.getSNCode(handlerSNCode, Long.toString(GlobalData.getUserID(CourtesyActivity.this)),  strMACAddr);
//                GlobalData.showToast(CourtesyActivity.this, getString(R.string.gift_fail));
//                btnStart.setVisibility(View.VISIBLE);
//                btnSend.setVisibility(View.INVISIBLE);
//                txtPassword.setVisibility(View.INVISIBLE);
            }
            else
            {
                GlobalData.showToast(CourtesyActivity.this, getString(R.string.network_error));

                return;
            }

            return;
        }
    };
    ProgressDialog progDialog = null;

    /**
     * Called when the activity is first created.
     */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (GlobalData.getTempID(CourtesyActivity.this) == 1)
            setContentView(R.layout.activity_courtesy);
        else if (GlobalData.getTempID(CourtesyActivity.this) == 2)
            setContentView(R.layout.activity_courtesy_2);
        else
            setContentView(R.layout.activity_courtesy);

        rlMainBack = (RelativeLayout)findViewById(R.id.rlCourtesyBack);
        rlMainBack.getViewTreeObserver().addOnGlobalLayoutListener(
                new ViewTreeObserver.OnGlobalLayoutListener() {
                    public void onGlobalLayout() {
                        if (bInitialized == false)
                        {
                            Rect r = new Rect();
                            rlMainBack.getLocalVisibleRect(r);
                            ResolutionSet._instance.setResolution(r.width(), r.height());
                            ResolutionSet._instance.iterateChild(findViewById(R.id.rlCourtesyBack));
                            bInitialized = true;
                        }
                    }
                }
        );

        initView();
    }

    private void initView()
    {
        imgBackFrame = (ImageView) findViewById(R.id.imgCourtesyBack);
        txtItem = (EditText) findViewById(R.id.txtCourtesy_Item);

        btnStart = (Button) findViewById(R.id.btnCourtesy_Start);
        btnStart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dlg = new ConfirmPwdDialog(CourtesyActivity.this);
                dlg.setOnDismissListener(CourtesyActivity.this);
                dlg.show();
            }
        });

        txtPassword = (EditText) findViewById(R.id.txtCourtesy_Password);
        btnSend = (Button) findViewById(R.id.btnCourtesy_Send);
        btnSend.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String strPassword = txtPassword.getText().toString();
                if (strPassword == null || strPassword.length() == 0)
                {
                    GlobalData.showToast(CourtesyActivity.this, getString(R.string.insertpassword));
                    return;
                }

                progDialog = ProgressDialog.show( CourtesyActivity.this,
                                               "",
                                                getString(R.string.waiting),
                                                true,
                                                false,
                                                null);
                CommMgr.commService.getReqGift(handlerReqGift,
                                                Long.toString(GlobalData.getUserID(CourtesyActivity.this)),
                                                strPassword,
                                                GlobalData.getCurrentMACAddress(CourtesyActivity.this),
                                                GlobalData.getSNCode(CourtesyActivity.this));
            }
        });
    }

    @Override
    public void onResume()
    {
        super.onResume();

        progDialog = ProgressDialog.show(
                CourtesyActivity.this,
                "",
                getString(R.string.waiting),
                true,
                false,
                null);
        CommMgr.commService.getGiftList(handlerGift, Long.toString(GlobalData.getUserID(CourtesyActivity.this)), GlobalData.getCurrentMACAddress(CourtesyActivity.this));
    }

    @Override
    public void onDismiss(DialogInterface dialog)
    {
        dlg = (ConfirmPwdDialog) dialog;
        String strPass = dlg.getPassword();

        if (strPass != null && strPass.length()  == 4)
        {
            progDialog = ProgressDialog.show( CourtesyActivity.this,
                    "",
                    getString(R.string.waiting),
                    true,
                    false,
                    null);
            CommMgr.commService.checkGiftPass(handlerCheckGiftPass,
                    Long.toString(GlobalData.getUserID(CourtesyActivity.this)),
                    strPass);
        }
    }

    @Override
    public void onStop()
    {
        super.onStop();

        if (dlg != null && dlg.isShowing())
            dlg.dismiss();
    }
}
