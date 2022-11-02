package com.baidu.mapapi.utils.coverter;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.baidu.mapapi.model.LatLng;

public class FlutterDataConveter {

    /**
     * 将map形式的经纬度信息转换为结构化的经纬度数据
     *
     * @param latlngMap
     * @return
     */
    public static LatLng mapToLatLng(Map<String, Object> latlngMap) {
        if (null == latlngMap) {
            return null;
        }

        if (!latlngMap.containsKey("latitude")
                || !latlngMap.containsKey("longitude")) {
            return null;
        }

        Object latitudeObj = latlngMap.get("latitude");
        Object longitudeObj = latlngMap.get("longitude");
        if (null == latitudeObj || null == longitudeObj) {
            return null;
        }
        LatLng latLng = new LatLng((double) latitudeObj, (double) longitudeObj);
        return latLng;
    }

    /**
     * 将多个map形式的经纬度信息转换为结构化的经纬度数据
     *
     * @param latlngList
     * @return
     */
    public static List<LatLng> mapToLatLngs(List<Map<String, Double>> latlngList) {
        if (null == latlngList) {
            return null;
        }

        Iterator itr = latlngList.iterator();
        ArrayList<LatLng> latLngs = new ArrayList<>();
        while (itr.hasNext()) {
            Map<String, Object> latlngMap = (Map<String, Object>) itr.next();
            LatLng latLng = mapToLatLng(latlngMap);
            if (null == latLng) {
                break;
            }

            latLngs.add(latLng);
        }

        if (latLngs.size() != latlngList.size()) {
            return null;
        }

        return latLngs;
    }
}
