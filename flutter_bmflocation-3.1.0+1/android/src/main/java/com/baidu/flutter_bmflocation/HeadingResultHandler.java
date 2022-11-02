package com.baidu.flutter_bmflocation;

import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.text.TextUtils;
import android.util.Log;

import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class HeadingResultHandler extends MethodChannelHandler implements SensorEventListener {

    private static final String TAG = HeadingResultHandler.class.getSimpleName();

    private Double lastX = 0.0;

    private SensorManager mSensorManager;

    // 初始化channel
    public HeadingResultHandler() {
        mMethodChannel = MethodChannelManager.getInstance().getLocationChannel();
    }

    // 执行flutter传过来的方法
    @Override
    public void handleMethodHeadingCallResult(Context context, MethodCall call, MethodChannel.Result result) {
        super.handleMethodHeadingCallResult(context, call, result);

        if (call.method.equals(Constants.MethodID.LOCATION_STARTHEADING)) {
            try {
                // 开始定位
                boolean ret = false;
                // 获取传感器管理服务
                mSensorManager = (SensorManager) context.getSystemService(context.SENSOR_SERVICE);
                // 为系统的方向传感器注册监听器
                mSensorManager.registerListener(this, 
                mSensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION), 
                SensorManager.SENSOR_DELAY_UI);
                ret = true;
                sendReturnResult(ret);
            } catch (Exception e) {
                Log.e(TAG, e.toString());
            }
        }else if (call.method.equals(Constants.MethodID.LOCATION_STOPHEADING)) {

            mSensorManager.unregisterListener(this);
        }
    }

    @Override
    public void onSensorChanged(SensorEvent sensorEvent) {

        double x = sensorEvent.values[0];

        Map<String, Object> result = new LinkedHashMap<>();

        if (Math.abs(x - lastX) > 0.1) {
            result.put("trueHeading", x);
            result.put("timestamp", formatUTC(System.currentTimeMillis(), "yyyy-MM-dd HH:mm:ss"));
            result.put("headingAccuracy", (sensorEvent.accuracy) + 0.0);
            sendResultCallback(Constants.MethodID.LOCATION_STARTHEADING, result, 0);
        }
        lastX = x;
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }

    /**
     * 格式化时间
     *
     * @param time
     * @param strPattern
     * @return
     */
    private String formatUTC(long time, String strPattern) {
        if (TextUtils.isEmpty(strPattern)) {
            strPattern = "yyyy-MM-dd HH:mm:ss";
        }
        SimpleDateFormat sdf = null;
        try {
            sdf = new SimpleDateFormat(strPattern, Locale.CHINA);
            sdf.applyPattern(strPattern);
        } catch (Throwable e) {
            e.printStackTrace();
        }
        return sdf == null ? "NULL" : sdf.format(time);
    }

}
