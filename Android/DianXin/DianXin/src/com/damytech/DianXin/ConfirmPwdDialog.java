package com.damytech.DianXin;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import com.damytech.Utils.GlobalData;
import com.damytech.Utils.ResolutionSet;

public class ConfirmPwdDialog extends Dialog
{
    Context mContext;EditText txtPassword;
    Button btnOne, btnTwo, btnThree, btnFour, btnFive, btnSix, btnSeven, btnEight, btnNine, btnZero, btnClear, btnOk;

    String strPass = "";
    OnDismissListener dismissListener = null;

    public ConfirmPwdDialog(Context context)
    {
        super(context);
        mContext = context;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.dlg_confirmpwd);

        ResolutionSet._instance.iterateChild(((RelativeLayout)findViewById(R.id.parent_layout)).getChildAt(0));

        initControl();
    }

    private void initControl()
    {
        txtPassword = (EditText) findViewById(R.id.txtPassword);

        btnOne = (Button) findViewById(R.id.btnOne);
        btnOne.setOnClickListener(onClickListener);
        btnTwo = (Button) findViewById(R.id.btnTwo);
        btnTwo.setOnClickListener(onClickListener);
        btnThree = (Button) findViewById(R.id.btnThree);
        btnThree.setOnClickListener(onClickListener);
        btnFour = (Button) findViewById(R.id.btnFour);
        btnFour.setOnClickListener(onClickListener);
        btnFive = (Button) findViewById(R.id.btnFive);
        btnFive.setOnClickListener(onClickListener);
        btnSix = (Button) findViewById(R.id.btnSix);
        btnSix.setOnClickListener(onClickListener);
        btnSeven = (Button) findViewById(R.id.btnSeven);
        btnSeven.setOnClickListener(onClickListener);
        btnEight = (Button) findViewById(R.id.btnEight);
        btnEight.setOnClickListener(onClickListener);
        btnNine = (Button) findViewById(R.id.btnNine);
        btnNine.setOnClickListener(onClickListener);
        btnZero = (Button) findViewById(R.id.btnZero);
        btnZero.setOnClickListener(onClickListener);
        btnOk = (Button) findViewById(R.id.btnOk);
        btnOk.setOnClickListener(onClickListener);
        btnClear = (Button) findViewById(R.id.btnClear);
        btnClear.setOnClickListener(onClickListener);
    }

    public void setOnDismissListener(OnDismissListener listener)
    {
        dismissListener = listener;
    }

    public String getPassword()
    {
        strPass = txtPassword.getText().toString();
        return strPass;
    }

    View.OnClickListener onClickListener = new View.OnClickListener()
    {
        @Override
        public void onClick(View v)
        {
            if (v.getId() == R.id.btnClear)
            {
                txtPassword.setText("");
                strPass = "";
                return;
            }
            if (v.getId() == R.id.btnOk)
            {
                strPass = txtPassword.getText().toString();
                if (strPass != null && strPass.length() > 4)
                {
                    GlobalData.showToast(mContext, mContext.getResources().getString(R.string.passmaxlength));
                    return;
                }

                dismissListener.onDismiss(ConfirmPwdDialog.this);
                dismiss();

                return;
            }

            switch (v.getId())
            {
                case R.id.btnOne:
                    strPass += "1";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnTwo:
                    strPass += "2";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnThree:
                    strPass += "3";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnFour:
                    strPass += "4";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnFive:
                    strPass += "5";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnSix:
                    strPass += "6";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnSeven:
                    strPass += "7";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnEight:
                    strPass += "8";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnNine:
                    strPass += "9";
                    txtPassword.setText(strPass);
                    break;
                case R.id.btnZero:
                    strPass += "0";
                    txtPassword.setText(strPass);
                    break;
            }
        }
    };
}