package com.baidu.flutter_bmflocation;

import android.util.Log;

import com.baidu.flutter_bmflocation.MethodChannelManager;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LocationSetOptionsHandler  extends MethodChannelHandler{

    private static final String TAG = LocationSetOptionsHandler.class.getSimpleName();

     // 初始化channel
    public LocationSetOptionsHandler() {
        mMethodChannel = MethodChannelManager.getInstance().getLocationChannel();
    }

     // 执行flutter传过来的方法
    @Override
    public void handleMethodCallResult(LocationClient mLocationClient, MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(mLocationClient, call, result);

        if (null == mLocationClient) {
            sendReturnResult(false);
        }

        try {
            boolean ret = updateOption(mLocationClient, (Map) call.arguments, result);
            sendReturnResult(ret);
        } catch (Exception e) {
            Log.e(TAG, e.toString());
        }
    }

     // 设置参数
    private boolean updateOption(LocationClient mLocationClient, Map arguments, MethodChannel.Result result) {

        boolean ret = false;

        if (arguments != null) {

            LocationClientOption option = new LocationClientOption();

            // 可选，设置是否返回逆地理地址信息。默认是true
            if (arguments.containsKey("isNeedAddress") && arguments.get("isNeedAddress") != null) {
                if (((boolean) arguments.get("isNeedAddress"))) {
                    option.setIsNeedAddress(true);
                } else {
                    option.setIsNeedAddress(false);
                }
            }

            // 可选，设置定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
            if (arguments.containsKey("locationMode") && arguments.get("locationMode") != null) {
                if (((int) arguments.get("locationMode")) == 0) {
                    option.setLocationMode(LocationClientOption.LocationMode.Hight_Accuracy); // 高精度模式
                } else if (((int) arguments.get("locationMode")) == 1) {
                    option.setLocationMode(LocationClientOption.LocationMode.Device_Sensors); // 仅设备模式
                } else if (((int) arguments.get("locationMode")) == 2) {
                    option.setLocationMode(LocationClientOption.LocationMode.Battery_Saving); // 仅网络模式
                }else {
                    option.setLocationMode(LocationClientOption.LocationMode.Hight_Accuracy); // 高精度模式
                }
            }

            // 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
            if (arguments.containsKey("locationPurpose") && arguments.get("locationPurpose") != null) {
                if (((int) arguments.get("locationPurpose")) == 0) {
                    option.setLocationPurpose(LocationClientOption.BDLocationPurpose.SignIn); // 签到场景
                } else if (((int) arguments.get("locationPurpose")) == 1) {
                    option.setLocationPurpose(LocationClientOption.BDLocationPurpose.Transport); // 运动场景
                } else if (((int) arguments.get("locationPurpose")) == 2) {
                    option.setLocationPurpose(LocationClientOption.BDLocationPurpose.Sport); // 出行场景
                }
            }

            // 可选，设置需要返回海拔高度信息
            if (arguments.containsKey("isNeedAltitude") && arguments.get("isNeedAltitude") != null) {
                if (((boolean) arguments.get("isNeedAltitude"))) {
                    option.setIsNeedAltitude(true);
                } else {
                    option.setIsNeedAltitude(false);
                }
            }

            // 可选，设置是否使用gps，默认false
            if (arguments.containsKey("openGps") && arguments.get("openGps") != null) {
                if (((boolean) arguments.get("openGps"))) {
                    option.setOpenGps(true);
                } else {
                    option.setOpenGps(false);
                }
            }

            // 可选，设置是否允许返回逆地理地址信息，默认是true
            if (arguments.containsKey("isNeedLocationDescribe") && arguments.get("isNeedLocationDescribe") != null) {
                if (((boolean) arguments.get("isNeedLocationDescribe"))) {
                    option.setIsNeedLocationDescribe(true);
                } else {
                    option.setIsNeedLocationDescribe(false);
                }
            }

            // 可选，设置发起定位请求的间隔，int类型，单位ms
            // 如果设置为0，则代表单次定位，即仅定位一次，默认为0
            // 如果设置非0，需设置1000ms以上才有效
            if (arguments.containsKey("scanspan") && arguments.get("scanspan") != null) {
                option.setScanSpan((int) arguments.get("scanspan"));
            }

            // 可选，设置返回经纬度坐标类型，默认bd09ll
            if (arguments.containsKey("coorType") && arguments.get("coorType") != null) {
                option.setCoorType((String) arguments.get("coorType"));
            }

            if (arguments.containsKey("coordType") && arguments.get("coordType") != null) {
                if (((int) arguments.get("coordType")) == 0) {
                    option.setCoorType("gcj02");
                } else if (((int) arguments.get("coordType")) == 1) {
                    option.setCoorType("wgs84");
                } else if (((int) arguments.get("coordType")) == 2) {
                    option.setCoorType("bd09ll");
                }else{
                    option.setCoorType("gcj02");
                }
            }

            // 设置是否需要返回附近的poi列表
            if (arguments.containsKey("isNeedLocationPoiList") && arguments.get("isNeedLocationPoiList") != null) {
                if (((boolean) arguments.get("isNeedLocationPoiList"))) {
                    option.setIsNeedLocationPoiList(true);
                } else {
                    option.setIsNeedLocationPoiList(false);
                }
            }
            // 设置是否需要最新版本rgc数据
            if (arguments.containsKey("isNeedNewVersionRgc") && arguments.get("isNeedNewVersionRgc") != null) {
                if (((boolean) arguments.get("isNeedNewVersionRgc"))) {
                    option.setIsNeedLocationPoiList(true);
                } else {
                    option.setIsNeedLocationPoiList(false);
                }
            }
            option.setProdName("flutter");
            mLocationClient.setLocOption(option);
            ret = true;
        }
        return ret;
    }
}