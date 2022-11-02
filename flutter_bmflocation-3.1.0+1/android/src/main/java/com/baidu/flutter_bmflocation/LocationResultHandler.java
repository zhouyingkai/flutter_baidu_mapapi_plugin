package com.baidu.flutter_bmflocation;

import android.text.TextUtils;
import android.util.Log;

import com.baidu.flutter_bmflocation.MethodChannelManager;
import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.baidu.location.LocationClient;
import com.baidu.location.Poi;
import com.baidu.location.PoiRegion;

import java.text.SimpleDateFormat;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class LocationResultHandler extends MethodChannelHandler {
    private static final String TAG = LocationResultHandler.class.getSimpleName();

    private CurrentLocationListener listener;

    // 初始化channel
    public LocationResultHandler() {
        mMethodChannel = MethodChannelManager.getInstance().getLocationChannel();
    }

     // 执行flutter传过来的方法
    @Override
    public void handleMethodCallResult(LocationClient mLocationClient, MethodCall call, MethodChannel.Result result) {
        super.handleMethodCallResult(mLocationClient, call, result);

        if (null == mLocationClient) {
            sendReturnResult(false);
        }
        if (listener == null) {
            listener = new CurrentLocationListener();
        }

        if (call.method.equals(Constants.MethodID.LOCATION_SERIESLOC)) {
            try {
                 // 开始定位
                boolean ret = false;
                mLocationClient.registerLocationListener(listener);
                mLocationClient.start();
                ret = true;
                sendReturnResult(ret);
            } catch (Exception e) {
                Log.e(TAG, e.toString());
            }
        }else if (call.method.equals(Constants.MethodID.LOCATION_STOPLOC)) {
             // 停止定位
            mLocationClient.stop();
            mLocationClient.unRegisterLocationListener(listener);
            listener = null;
            sendReturnResult(true);
        }
    }

    class CurrentLocationListener extends BDAbstractLocationListener {

        @Override
        public void onReceiveLocation(BDLocation bdLocation) {

            if (null == bdLocation) {
                sendResultCallback(Constants.MethodID.LOCATION_SERIESLOC, "bdLocation is null", -1);
                return;
            }
//            Log.e(TAG, "onReceiveLocation: \"定位结果返回\"" + bdLocation.toString());
            Map<String, Object> result = new LinkedHashMap<>();

            // 场景定位获取结果
//            if (locationClient.getLocOption().getLocationPurpose) {
//                result.put("latitude", bdLocation.getLatitude()); // 纬度
//                result.put("longitude", bdLocation.getLongitude()); // 经度
//                flutterResult.success(result);
//                return;
//            }

            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation) {
                result.put("callbackTime", formatUTC(System.currentTimeMillis(), "yyyy-MM-dd HH:mm:ss"));
                result.put("locType", bdLocation.getLocType()); // 定位结果类型
                if (bdLocation.getTime() != null && !TextUtils.isEmpty(bdLocation.getTime())) {
                    result.put("locTime", bdLocation.getTime()); // 定位成功时间
                }

                result.put("probability", bdLocation.getMockGpsProbability()); //作弊概率
                result.put("course", bdLocation.getDirection()); // 航向
                result.put("latitude", bdLocation.getLatitude()); // 纬度
                result.put("longitude", bdLocation.getLongitude()); // 经度
                result.put("speed", bdLocation.getSpeed()); // 速度
                if (bdLocation.hasAltitude()) {
                    result.put("altitude", bdLocation.getAltitude()); // 高度
                }
                result.put("radius", Double.parseDouble(String.valueOf(bdLocation.getRadius()))); // 定位精度
                if (bdLocation.getCountry() != null && !TextUtils.isEmpty(bdLocation.getCountry())){
                    result.put("country", bdLocation.getCountry()); // 国家
                }
                if (bdLocation.getProvince() != null && !TextUtils.isEmpty(bdLocation.getProvince())) {
                    result.put("province", bdLocation.getProvince()); // 省份
                }
                if (bdLocation.getCity() != null && !TextUtils.isEmpty(bdLocation.getCity())) {
                    result.put("city", bdLocation.getCity()); // 城市
                }
                if (bdLocation.getDistrict() != null && !TextUtils.isEmpty(bdLocation.getDistrict())) {
                    result.put("district", bdLocation.getDistrict()); // 区域
                }
                if (bdLocation.getTown() != null && !TextUtils.isEmpty(bdLocation.getTown())) {
                    result.put("town", bdLocation.getTown()); // 城镇
                }
                if (bdLocation.getStreet() != null && !TextUtils.isEmpty(bdLocation.getStreet())) {
                    result.put("street", bdLocation.getStreet()); // 街道
                }
                if (bdLocation.getAddrStr() != null && !TextUtils.isEmpty(bdLocation.getAddrStr())) {
                    result.put("address", bdLocation.getAddrStr()); // 地址
                }
                if (bdLocation.getAdCode() != null && !TextUtils.isEmpty(bdLocation.getAdCode())) {
                    result.put("adCode", bdLocation.getAdCode()); // 行政区划编码
                }
                if (bdLocation.getCityCode() != null && !TextUtils.isEmpty(bdLocation.getCityCode())) {
                    result.put("cityCode", bdLocation.getCityCode()); // 城市编码
                }
                if (bdLocation.getStreetNumber() != null && !TextUtils.isEmpty(bdLocation.getStreetNumber())) {
                    result.put("getStreetNumber", bdLocation.getStreetNumber()); // 街道编码
                }
                if (bdLocation.getLocationDescribe() != null && !TextUtils.isEmpty(bdLocation.getLocationDescribe())) {
                    result.put("locationDetail", bdLocation.getLocationDescribe()); // 位置语义化描述
                }
                if (null != bdLocation.getPoiList() && !bdLocation.getPoiList().isEmpty()) {
                    List<Poi> pois = bdLocation.getPoiList();
                    List<Map> poiList = new LinkedList<>();
                    for (int i = 0; i < pois.size(); i++) {
                        Map<String, String> poiMap = new LinkedHashMap<>();
                        Poi p = pois.get(i);
                        poiMap.put("tags", p.getTags());
                        poiMap.put("name", p.getName());
                        poiMap.put("addr", p.getAddr());
                        poiList.add(poiMap);
                    }
                    result.put("pois", poiList); // 周边poi信息
                }

                // 兼容旧版本poiList
                if (null != bdLocation.getPoiList() && !bdLocation.getPoiList().isEmpty()) {
                    List<Poi> pois = bdLocation.getPoiList();
                    StringBuilder stringBuilder = new StringBuilder();
                    if (pois.size() == 1) {
                        stringBuilder.append(pois.get(0).getName()).append(",").append(pois.get(0).getTags())
                                .append(pois.get(0).getAddr());
                    } else {
                        for (int i = 0; i < pois.size() - 1; i++) {
                            stringBuilder.append(pois.get(i).getName()).append(",").append(pois.get(i).getTags())
                                    .append(pois.get(i).getAddr()).append("|");
                        }
                        stringBuilder.append(pois.get(pois.size() - 1).getName()).append(",")
                                .append(pois.get(pois.size() - 1).getTags())
                                .append(pois.get(pois.size() - 1).getAddr());
                    }
                    result.put("poiList", stringBuilder.toString()); // 周边poi信息
                }

                if (null != bdLocation.getPoiRegion()) {
                    PoiRegion poi = bdLocation.getPoiRegion();
                    Map regonMap = new LinkedHashMap<>();
                    regonMap.put("tags", poi.getTags());
                    regonMap.put("name", poi.getName());
                    regonMap.put("directionDesc", poi.getDerectionDesc());
                    result.put("poiRegion", regonMap); // 当前位置poi信息
                }
//          if (bdLocation.getFloor() != null) {
//            // 当前支持高精度室内定位
//            String buildingID = bdLocation.getBuildingID();// 百度内部建筑物ID
//            String buildingName = bdLocation.getBuildingName();// 百度内部建筑物缩写
//            String floor = bdLocation.getFloor();// 室内定位的楼层信息，如 f1,f2,b1,b2
//            StringBuilder stringBuilder = new StringBuilder();
//            stringBuilder.append(buildingID).append("-").append(buildingName).append("-").append(floor);
//            result.put("indoor", stringBuilder.toString()); // 室内定位结果信息
//            // 开启室内定位模式（重复调用也没问题），开启后，定位SDK会融合各种定位信息（GPS,WI-FI，蓝牙，传感器等）连续平滑的输出定位结果；
//            mLocationClient.startIndoorMode();
//          } else {
//            mLocationClient.stopIndoorMode(); // 处于室外则关闭室内定位模式
//          }
                 // android端实时检测位置变化，将位置结果发送到flutter端
                sendResultCallback(Constants.MethodID.LOCATION_SERIESLOC, result, 0);

            } else {
                // 定位结果错误码
                // 定位失败描述信息
                int type = bdLocation.getLocType();
                String des = bdLocation.getLocTypeDescription();
                // android端实时检测位置变化，将位置结果发送到flutter端
                sendResultCallback(Constants.MethodID.LOCATION_SERIESLOC,
                 bdLocation.getLocTypeDescription(), bdLocation.getLocType());
            }
        }
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
