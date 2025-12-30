/*******************************************************************************
 * Copyright 2011-2013 Sergey Tarasevich
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *******************************************************************************/
package com.damytech.DianXin;

import android.app.*;
import android.content.Intent;
import android.os.Environment;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ChangLiangApplication extends Application {
	@Override
	public void onCreate()
    {
		super.onCreate();

        startService(new Intent(getApplicationContext(), ScreenService.class));
	}

    @Override
    public void onTerminate()
    {
        ScreenManager.reenableKeyguard();

        super.onTerminate();
    }

    public static void WriteLog(String logString)
    {
        String strFormat = "yyyy-MM-dd HH:mm:ss";
        SimpleDateFormat sdf = new SimpleDateFormat(strFormat);
        File f = new File(Environment.getExternalStorageDirectory(), "Download/ChangLiang.log");
        String strLog = sdf.format(new Date()) + "   "  + logString + "\r\n";

        try {
            OutputStream os = new FileOutputStream(f, true);
            os.write(strLog.getBytes());
            os.close();
        } catch (Exception e) {
        }
    }
}
