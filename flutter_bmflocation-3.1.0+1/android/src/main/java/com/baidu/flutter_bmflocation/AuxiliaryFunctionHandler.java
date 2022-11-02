package com.baidu.flutter_bmflocation;

import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.baidu.location.LocationClient;

import java.util.LinkedHashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AuxiliaryFunctionHandler extends MethodChannelHandler {
    private static final String TAG = LocationResultHandler.class.getSimpleName();

    private MyLocationListener myListener = new MyLocationListener();

    // 初始化channel
    public AuxiliaryFunctionHandler() {
        mMethodChannel = MethodChannelManager.getInstance().getLocationChannel();
    }

    @Override
    public void handleMethodCallResult(LocationClient mLocationClient, MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(mLocationClient, call, result);
        if (null == mLocationClient) {
            sendReturnResult(false);
        }

        if (call.method.equals(Constants.MethodID.LOCATION_NERWORKSTATE)) {
            mLocationClient.start();
            mLocationClient.registerLocationListener(myListener);
            mLocationClient.requestHotSpotState();
        }
    }

    class MyLocationListener extends BDAbstractLocationListener{


        @Override
        public void onConnectHotSpotMessage(String connectWifiMac, int hotSpotState){
            Map<String, Object> map = new LinkedHashMap<>();
            if (hotSpotState == 0){
                map.put("state", 1);
            } else if (hotSpotState == 1){
                map.put("state", 2);
            } else if (hotSpotState == -1){
                map.put("state", 5);
            }
            sendResultCallback(Constants.MethodID.LOCATION_MONITORGEOFENCE, map, 0);
        }
        @Override
        public void onReceiveLocation(BDLocation bdLocation) {

        }
    }

}

