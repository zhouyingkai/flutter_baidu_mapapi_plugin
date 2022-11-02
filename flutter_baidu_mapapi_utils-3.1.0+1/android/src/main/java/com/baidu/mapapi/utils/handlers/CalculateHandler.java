package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.utils.AreaUtil;
import com.baidu.mapapi.utils.CoordinateConverter;
import com.baidu.mapapi.utils.DistanceUtil;
import com.baidu.mapapi.utils.MethodID;
import com.baidu.mapapi.utils.SpatialRelationUtil;
import com.baidu.mapapi.utils.bean.ConverOptionBean;
import com.baidu.mapapi.utils.coverter.FlutterDataConveter;
import com.baidu.mapapi.utils.coverter.TypeConverter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import com.baidu.mapapi.utils.Env;

/**
 * 计算工具handler
 */
public class CalculateHandler extends MethodChannelHandler {

    public static final String TAG = CalculateHandler.class.getSimpleName();

    @Override
    public void handlerMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handlerMethodCallResult(call, result);
        if (Env.DEBUG) {
            Log.d(TAG, "handlerMethodCallResult enter" + call.arguments.toString());
        }

        if (null == call || null == result) {
            returnResult(null);
            return;
        }

        if (null == call.arguments) {
            returnResult(null);
            return;
        }

        HashMap<String, Object> argumentMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentMap) {
            returnResult(null);
            return;
        }

        String methodId = call.method;
        switch (methodId) {
            case MethodID.CalcMethodID.kCoordTypeConvert:
                convertCoord(argumentMap, result);
                break;
            case MethodID.CalcMethodID.kCalculateRectArea:
                calcRectArea(argumentMap, result);
                break;
            case MethodID.CalcMethodID.kCalculatePolygonArea:
                calcPolygonArea(argumentMap, result);
                break;
            case MethodID.CalcMethodID.kPolygonContainsCoord:
                isPolygonContainsPoint(argumentMap, result);
                break;
            case MethodID.CalcMethodID.kCircleContainsCoord:
                isCircleContainsPoint(argumentMap, result);
                break;
            case MethodID.CalcMethodID.kLocationDistance:
                getLocationDistance(argumentMap, result);
                break;
            case MethodID.CalcMethodID.kNearestPointToLine:
                getNearestPointToLine(argumentMap, result);
                break;
            default:
                break;
        }

    }

    /**
     * 计算矩形面积
     *
     * @param argumentMap
     * @param result
     */
    private void calcRectArea(HashMap<String, Object> argumentMap, MethodChannel.Result result) {
        HashMap<String, Object> leftTopMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "leftTop");
        if (null == leftTopMap) {
            returnResult(-1.0);
            return;
        }

        LatLng leftTop = FlutterDataConveter.mapToLatLng(leftTopMap);
        if (null == leftTop) {
            returnResult(-1.0);
            return;
        }

        HashMap<String, Object> rightBottomMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "rightBottom");
        if (null == rightBottomMap) {
            returnResult(-1.0);
            return;
        }

        LatLng rightBottom = FlutterDataConveter.mapToLatLng(rightBottomMap);
        if (null == leftTop) {
            returnResult(-1.0);
            return;
        }

        Double area = AreaUtil.calculateArea(leftTop, rightBottom);

        returnResult(area);
    }

    /**
     * 计算多边形面积
     *
     * @param argumentMap
     * @param result
     */
    private void calcPolygonArea(HashMap<String, Object> argumentMap, MethodChannel.Result result) {
        List<Map<String, Double>> latLngList =
                (List<Map<String, Double>>) argumentMap.get("polygon");
        List<LatLng> latLngs =
                com.baidu.mapapi.utils.coverter.FlutterDataConveter.mapToLatLngs(latLngList);
        if (null == latLngs) {
            returnResult(-1.0);
            return;
        }

        Double area = AreaUtil.calculateArea(latLngs);
        returnResult(area);
    }

    /**
     * 坐标类型转换
     *
     * @param argumentMap
     * @param result
     */
    private void convertCoord(HashMap<String, Object> argumentMap, MethodChannel.Result result) {

        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
        String json = gson.toJson(argumentMap);
        if (TextUtils.isEmpty(json)) {
            returnResult("coordinate", null);
            return;
        }

        ConverOptionBean convertOptionBean = gson.fromJson(json, ConverOptionBean.class);

        if (null == convertOptionBean) {
            returnResult("coordinate", null);
            return;
        }
        CoordinateConverter coordinateConverter = new CoordinateConverter();
        coordinateConverter.coord(convertOptionBean.coordinate);
        coordinateConverter
                .from(CoordinateConverter.CoordType.values()[convertOptionBean.fromType]);
        LatLng latLng = coordinateConverter.convert();
        if (null == latLng) {
            returnResult("coordinate", null);
            return;
        }

        String resultJson = gson.toJson(latLng);
        HashMap<String, Object> resultMap =
                gson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                }.getType());

        returnResult("coordinate", resultMap);
    }

    /**
     * 判断点是否再多边形内部
     *
     * @param argumentMap
     * @param result
     */
    private void isPolygonContainsPoint(HashMap<String, Object> argumentMap,
                                        MethodChannel.Result result) {
        HashMap<String, Object> coordinateMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "coordinate");
        if (null == coordinateMap) {
            returnResult(null);
            return;
        }

        LatLng coordinate = FlutterDataConveter.mapToLatLng(coordinateMap);
        if (null == coordinate) {
            returnResult(null);
        }

        List<Map<String, Double>> polygonList =
                new TypeConverter<List<Map<String, Double>>>().getValue(argumentMap, "polygon");
        List<LatLng> polygonCoords = FlutterDataConveter.mapToLatLngs(polygonList);
        if (null == polygonCoords) {
            returnResult(null);
        }

        Boolean ret = SpatialRelationUtil.isPolygonContainsPoint(polygonCoords, coordinate);
        returnResult(ret);
    }

    /**
     * 判断点是否在园内部
     *
     * @param argumentMap
     * @param result
     */
    private void isCircleContainsPoint(HashMap<String, Object> argumentMap,
                                       MethodChannel.Result result) {
        HashMap<String, Object> coordinateMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "coord");
        if (null == coordinateMap) {
            returnResult(null);
            return;
        }

        LatLng coordinate = FlutterDataConveter.mapToLatLng(coordinateMap);
        if (null == coordinate) {
            returnResult(null);
            return;
        }

        HashMap<String, Object> centerMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "center");
        if (null == centerMap) {
            returnResult(null);
            return;
        }

        LatLng center = FlutterDataConveter.mapToLatLng(centerMap);
        if (null == center) {
            returnResult(null);
            return;
        }

        Double radius = new TypeConverter<Double>().getValue(argumentMap, "radius");

        Boolean ret =
                SpatialRelationUtil.isCircleContainsPoint(center, radius.intValue(), coordinate);

        returnResult(ret);
    }

    /**
     * 获取两点间距
     *
     * @param argumentMap
     * @param result
     */
    private void getLocationDistance(HashMap<String, Object> argumentMap,
                                     MethodChannel.Result result) {
        HashMap<String, Object> startCoordMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "startCoord");
        if (null == startCoordMap) {
            returnResult(-1.0);
            return;
        }

        LatLng startCoord = FlutterDataConveter.mapToLatLng(startCoordMap);
        if (null == startCoord) {
            returnResult(-1.0);
            return;
        }

        HashMap<String, Object> endCoordMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "endCoord");
        if (null == endCoordMap) {
            returnResult(-1.0);
            return;
        }

        LatLng endCoord = FlutterDataConveter.mapToLatLng(endCoordMap);
        if (null == endCoord) {
            returnResult(-1.0);
            return;
        }

        Double distance = DistanceUtil.getDistance(startCoord, endCoord);
        returnResult(distance);
    }

    /**
     * 获取点到折线最近的点
     *
     * @param argumentMap
     * @param result
     */
    private void getNearestPointToLine(HashMap<String, Object> argumentMap,
                                       MethodChannel.Result result) {

        List<Map<String, Double>> polyLineList =
                new TypeConverter<List<Map<String, Double>>>().getValue(argumentMap, "polyLine");
        List<LatLng> polylineCoords = FlutterDataConveter.mapToLatLngs(polyLineList);
        if (null == polylineCoords) {
            returnResult(null);
            return;
        }

        HashMap<String, Object> coordinateMap =
                new TypeConverter<HashMap<String, Object>>().getValue(argumentMap, "coord");
        if (null == coordinateMap) {
            returnResult(null);
            return;
        }

        LatLng coordinate = FlutterDataConveter.mapToLatLng(coordinateMap);
        if (null == coordinate) {
            returnResult(null);
            return;
        }

        LatLng nearPoint = SpatialRelationUtil.getNearestPointFromLine(polylineCoords, coordinate);
        if (null == nearPoint) {
            returnResult(null);
            return;
        }

        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
        String resultJson = gson.toJson(nearPoint);
        HashMap<String, Object> resultMap =
                gson.fromJson(resultJson, new TypeToken<HashMap<String, Object>>() {
                }.getType());
        returnResult(resultMap);
    }

    //    private void getPointToTheVerticalFootOfLine(HashMap<String, Object> argumentMap,
    //    MethodChannel.Result result){
    //        LatLng point = new TypeConverter<LatLng>().getValue(argumentMap, "coord");
    //        if(null == point){
    //            return;
    //        }
    //
    //        LatLng lineStart = new TypeConverter<LatLng>().getValue(argumentMap, "lineStart");
    //        if(null == lineStart){
    //            return;
    //        }
    //
    //        LatLng lineEnd = new TypeConverter<LatLng>().getValue(argumentMap, "lineEnd");
    //        if(null == lineEnd){
    //            return;
    //        }
    //
    //        SpatialRelationUtil.
    //    }
}
