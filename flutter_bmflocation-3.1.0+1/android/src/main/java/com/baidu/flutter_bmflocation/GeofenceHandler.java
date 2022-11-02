package com.baidu.flutter_bmflocation;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.util.Log;

import com.baidu.flutter_bmflocation.MethodChannelManager;
import com.baidu.geofence.GeoFence;
import com.baidu.geofence.GeoFenceClient;
import com.baidu.geofence.GeoFenceListener;
import com.baidu.geofence.model.DPoint;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class GeofenceHandler extends MethodChannelHandler {

    private static final String TAG = LocationResultHandler.class.getSimpleName();

    public static final String GEOFENCE_BROADCAST_ACTION = "com.location.apis.geofencedemo.broadcast";

    static IntentFilter filter;

    // 初始化channel
    public GeofenceHandler() {
        mMethodChannel = MethodChannelManager.getInstance().getLocationChannel();
    }

    // 执行flutter传过来的方法
    @Override
    public void handleMethodGeofenceCallResult(
        Context mContext, GeoFenceClient mGeoFenceClient, MethodCall call, MethodChannel.Result result) {
        super.handleMethodGeofenceCallResult(mContext, mGeoFenceClient, call, result);

        if (null == mGeoFenceClient) {
            sendReturnResult(false);
        }

        if (null == filter) {
            // 创建回调监听
            GeoFenceListener fenceListenter = (list, i, s) -> {

                Map<String, Object> map = new LinkedHashMap<>();

                if (i == GeoFence.ADDGEOFENCE_SUCCESS || i == GeoFence.ERROR_CODE_EXISTS){
                    Log.e("创建回调监听", "成功");
                    List<Map> regions = analysisBMKGeoFenceRegions(list);
                    map.put("region", regions.get(regions.size() - 1));
                    sendResultCallback(Constants.MethodID.LOCATION_GEOFENCECALLBACK, map, 0);
                } else {
                    Log.e("创建回调监听", "失败");
                    sendResultCallback(Constants.MethodID.LOCATION_GEOFENCECALLBACK, map, i);
                }
            };
            mGeoFenceClient.setGeoFenceListener(fenceListenter);

            // 创建并设置PendingIntent
            mGeoFenceClient.createPendingIntent(GEOFENCE_BROADCAST_ACTION);

            filter = new IntentFilter();
            filter.addAction(GEOFENCE_BROADCAST_ACTION);
            mContext.registerReceiver(mGeoFenceReceiver, filter);
        }


        if (call.method.equals(Constants.MethodID.LOCATION_CIRCLEGEOFENCE) ||
                call.method.equals(Constants.MethodID.LOCATION_POLYGONGEOFENCE)) {

            try {
                // 添加地理围栏
                addGeofence(mGeoFenceClient, (Map) call.arguments);
            } catch (Exception e) {
                Log.e(TAG, e.toString());
            }
        } else if (call.method.equals(Constants.MethodID.LOCATION_GETALLGEOFENCEID)) {
            try {

                List<GeoFence> geofenceList = mGeoFenceClient.getAllGeoFence();
                List<Map> list = analysisBMKGeoFenceRegions(geofenceList);
                Map<String, Object> map = new LinkedHashMap<>();
                if (list.size() > 0) {
                    map.put("result", list);
                } else {
                    map.put("result", new LinkedHashMap<>());
                }
                result.success(map);
            } catch (Exception e) {
                Log.e(TAG, e.toString());
            }
        } else if (call.method.equals(Constants.MethodID.LOCATION_REMOVEGEOFENCE)) {
            mGeoFenceClient.removeGeoFence();
        } else {
            sendReturnResult(false);
        }
    }

    void addGeofence(GeoFenceClient mGeofenceClient, Map arguments){

        if (arguments != null) {

            mGeofenceClient.isHighAccuracyLoc(true); // 在即将触发侦听行为时允许开启高精度定位模式(开启gps定位，gps定位结果优先)

            String coordType = "";
            if (arguments.containsKey("coordType") && arguments.get("coordType") != null) {
                if (((int) arguments.get("coordType")) == 0) {
                    coordType = GeoFenceClient.GCJ02;
                } else if (((int) arguments.get("coordType")) == 1) {
                    coordType = GeoFenceClient.WGS84;
                } else if (((int) arguments.get("coordType")) == 2) {
                    coordType = GeoFenceClient.BD09LL;
                } else{
                    coordType = GeoFenceClient.GCJ02;
                }
            }

            if (arguments.containsKey("activateAction") && arguments.get("activateAction") != null) {
                mGeofenceClient.setActivateAction((int) arguments.get("activateAction") + 1);
            }

            if (arguments.containsKey("centerCoordinate") &&
                    arguments.get("centerCoordinate") != null &&
                    arguments.containsKey("radius") &&
                    arguments.get("radius") != null ) {

                Map map = (Map) arguments.get("centerCoordinate");

                DPoint centerPoint = new DPoint((Double) map.get("latitude"), (Double) map.get("longitude"));
                Log.e("radius", arguments.get("radius").toString());

                float radius = Float.parseFloat(arguments.get("radius").toString());;
                mGeofenceClient.addGeoFence(centerPoint, coordType, radius, arguments.get("customId").toString());

            } else if (arguments.containsKey("coordinateList") &&
                    arguments.get("coordinateList") != null ){

                String customId = arguments.get("customId").toString();

                ArrayList<DPoint> pointList = new ArrayList<DPoint>();
                List list = (List) arguments.get("coordinateList");
                for (int i = 0; i < list.size(); i++) {
                    Map coordMap = (Map) list.get(i);
                    DPoint point = new DPoint((double) coordMap.get("latitude"), (double) coordMap.get("longitude"));
                    pointList.add(point);
                }

                mGeofenceClient.addGeoFence(pointList, coordType, customId);
            } else {

                sendResultCallback(Constants.MethodID.LOCATION_GEOFENCECALLBACK, new LinkedList<>(), 2);
            }
        }
    }

    /**
     * 接收触发围栏后的广播,当添加围栏成功之后，会立即对所有围栏状态进行一次侦测，只会发送一次围栏和位置之间的初始状态；
     * 当触发围栏之后也会收到广播,对于同一触发行为只会发送一次广播不会重复发送，除非位置和围栏的关系再次发生了改变。
     */
    private BroadcastReceiver mGeoFenceReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals(GEOFENCE_BROADCAST_ACTION)) {
                Bundle bundle = intent.getExtras();
                int status = bundle.getInt(GeoFence.BUNDLE_KEY_FENCESTATUS);
                StringBuffer sb = new StringBuffer();
                Map<String, Object> map = new LinkedHashMap<>();
                switch (status) {
                    case GeoFence.INIT_STATUS_IN:
                        sb.append("围栏初始状态:在围栏内");
                        map.put("geoFenceRegionStatus", 1);
                        break;
                    case GeoFence.INIT_STATUS_OUT:
                        sb.append("围栏初始状态:在围栏外");
                        map.put("geoFenceRegionStatus", 3);
                        break;
                    case GeoFence.STATUS_LOCFAIL:
                        sb.append("定位失败,无法判定目标当前位置和围栏之间的状态");
                        map.put("geoFenceRegionStatus", 0);
                        break;
                    case GeoFence.STATUS_IN:
                        sb.append("进入围栏 ");
                        map.put("geoFenceRegionStatus", 1);
                        break;
                    case GeoFence.STATUS_OUT:
                        sb.append("离开围栏 ");
                        map.put("geoFenceRegionStatus", 3);
                        break;
                    case GeoFence.STATUS_STAYED:
                        sb.append("在围栏内停留超过10分钟 ");
                        map.put("geoFenceRegionStatus", 2);
                        break;
                    default:
                        break;
                }
                sendResultCallback(Constants.MethodID.LOCATION_MONITORGEOFENCE, map, 0);
            }
        }
    };

    List<Map> analysisBMKGeoFenceRegions(List<GeoFence> resultList) {
        List<Map> list = new LinkedList<>();

        for (int i = 0; i < resultList.size(); i++) {
            Map<String, Object> map = new LinkedHashMap<>();
            GeoFence geofence = resultList.get(i);

            map.put("geofenceId", geofence.getFenceId());
            map.put("customId", geofence.getCustomId());

            ArrayList<DPoint> points = geofence.getPoints();

            if (points == null) {
                DPoint point = geofence.getCenter();
                Map<String, Object> centerMap = new LinkedHashMap<>();
                centerMap.put("latitude", point.getLatitude());
                centerMap.put("longitude", point.getLongitude());
                map.put("centerCoordinate", centerMap);
                map.put("radius", geofence.getRadius());
                map.put("geofenceStyle", 0);
            } else {

                ArrayList<Map> pointList = new ArrayList<>();
                for (int j = 0; j < points.size(); j++) {
                    DPoint p = points.get(j);
                    Map<String, Object> centerMap = new LinkedHashMap<>();
                    centerMap.put("latitude", p.getLatitude());
                    centerMap.put("longitude", p.getLongitude());
                    pointList.add(centerMap);
                }
                map.put("coordinateList", pointList);
                map.put("coordinateCount", pointList.size());
                map.put("geofenceStyle", 1);
            }
            list.add(map);

        }
        return list;
    }
}
