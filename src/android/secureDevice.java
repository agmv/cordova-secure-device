/*
   Copyright 2016 André Vieira

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

package com.outsystemscloud.andrevieira;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CordovaWebView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.Exception;
import java.io.File;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.app.Application;
import android.app.KeyguardManager;
import android.content.ContentResolver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.Resources;
import android.provider.Settings;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;


public class secureDevice extends CordovaPlugin {

    
    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        boolean _isDeviceRooted = isDeviceRooted();
        boolean _isPasscodeSet = doesDeviceHaveSecuritySetup(cordova.getActivity());

        if (_isDeviceRooted || !_isPasscodeSet) {
            // Remove View
            View v = webView.getView();
            ViewGroup viewParent = (ViewGroup) v.getParent();
            viewParent.removeView(v);

            // Show message and quit
            Application app = cordova.getActivity().getApplication();
            String package_name = app.getPackageName();
            Resources resources = app.getResources();
            String message = resources.getString(resources.getIdentifier("message","string", package_name));
            String label = resources.getString(resources.getIdentifier("label","string", package_name));
            this.alert(message, label);
        }
    }

    /**
     * Detect weather device is rooted or not
     * @author trykov
     * @source https://github.com/trykovyura/cordova-plugin-root-detection
     */
    private boolean isDeviceRooted() {
        return checkBuildTags() || checkSuperUserApk() || checkFilePath();
    }
    private boolean checkBuildTags() {
        String buildTags = android.os.Build.TAGS;
        return buildTags != null && buildTags.contains("test-keys");
    }

    private boolean checkSuperUserApk() {
        return new File("/system/app/Superuser.apk").exists();
    }

    private boolean checkFilePath() {
        String[] paths = { "/sbin/su", "/system/bin/su", "/system/xbin/su", "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su",
                "/system/bin/failsafe/su", "/data/local/su" };
        for (String path : paths) {
            if (new File(path).exists()) return true;
        }
        return false;
    }



    /**
     * <p>Checks to see if the lock screen is set up with either a PIN / PASS / PATTERN</p>
     *
     * <p>For Api 16+</p>
     *
     * @return true if PIN, PASS or PATTERN set, false otherwise.
     * @author doridori
     * @source https://gist.github.com/doridori/54c32c66ef4f4e34300f
     */
    public static boolean doesDeviceHaveSecuritySetup(Context context)
    {
        return isPatternSet(context) || isPassOrPinSet(context);
    }

    /**
     * @param context
     * @return true if pattern set, false if not (or if an issue when checking)
     */
    private static boolean isPatternSet(Context context)
    {
        ContentResolver cr = context.getContentResolver();
        try
        {
            int lockPatternEnable = Settings.Secure.getInt(cr, Settings.Secure.LOCK_PATTERN_ENABLED);
            return lockPatternEnable == 1;
        }
        catch (Settings.SettingNotFoundException e)
        {
            
            return false;
        }
    }

    /**
     * @param context
     * @return true if pass or pin set
     */
    @SuppressLint("NewApi") 
    private static boolean isPassOrPinSet(Context context)
    {
        KeyguardManager keyguardManager = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE); //api 16+
        return keyguardManager.isKeyguardSecure();
    }

    /**
     * Builds and shows a native Android alert with given Strings
     * @param message           The message the alert should display
     * @param buttonLabel       The label of the button
     * @param callbackContext   The callback context
     */
    private synchronized void alert(final String message, final String buttonLabel) {
        final CordovaInterface cordova = this.cordova;
        final Activity activity = cordova.getActivity();

        Runnable runnable = new Runnable() {
            public void run() {

                AlertDialog.Builder dlg = createDialog(cordova);
                dlg.setMessage(message);
                dlg.setCancelable(true);
                dlg.setPositiveButton(buttonLabel,
                        new AlertDialog.OnClickListener() {
                            public void onClick(DialogInterface dialog, int which) {
                                dialog.dismiss();
                                System.exit(0);
                            }
                        });                
                dlg.setOnDismissListener(new DialogInterface.OnDismissListener() {
                    public void onDismiss(final DialogInterface dialog) {
                        System.exit(0);
                    }
                });
                changeTextDirection(dlg);
            };
        };
        this.cordova.getActivity().runOnUiThread(runnable);
    }

    @SuppressLint("NewApi")
    private AlertDialog.Builder createDialog(CordovaInterface cordova) {
        int currentapiVersion = android.os.Build.VERSION.SDK_INT;
        if (currentapiVersion >= android.os.Build.VERSION_CODES.HONEYCOMB) {
            return new AlertDialog.Builder(cordova.getActivity(), AlertDialog.THEME_DEVICE_DEFAULT_LIGHT);
        } else {
            return new AlertDialog.Builder(cordova.getActivity());
        }
    }

    @SuppressLint("NewApi")
    private void changeTextDirection(Builder dlg){
        int currentapiVersion = android.os.Build.VERSION.SDK_INT;
        dlg.create();
        AlertDialog dialog =  dlg.show();
        if (currentapiVersion >= android.os.Build.VERSION_CODES.JELLY_BEAN_MR1) {
            TextView messageview = (TextView)dialog.findViewById(android.R.id.message);
            messageview.setTextDirection(android.view.View.TEXT_DIRECTION_LOCALE);
        }
    }
}
