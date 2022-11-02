package com.baidu.mapapi.utils.handlers;

import java.util.HashMap;

import com.baidu.mapapi.utils.Constants;
import com.baidu.mapapi.utils.FlutterBmfUtilsPlugin;
import com.baidu.mapapi.utils.bean.OpenRouteOptionBean;
import com.baidu.mapapi.utils.route.BaiduMapRoutePlan;
import com.baidu.mapapi.utils.route.RouteParaOption;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import android.content.Context;
import android.text.TextUtils;
import android.util.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import com.baidu.mapapi.utils.Env;

/**
 * 打开路径规划
 */
public class OpenBaiduRouteHandler extends MethodChannelHandler {

    public static final String TAG = OpenBaiduRouteHandler.class.getSimpleName();

    @Override
    public void handlerMethodCallResult(MethodCall call, MethodChannel.Result result) {
        super.handlerMethodCallResult(call, result);
        if (Env.DEBUG) {
            Log.d(TAG, "handlerMethodCallResult enter" + call.arguments.toString());
        }

        if (null == call.arguments) {
            returnResult(Constants.ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        HashMap<String, Object> argumentsMap = (HashMap<String, Object>) call.arguments;
        if (null == argumentsMap) {
            returnResult(Constants.ErrorCode.OPEN_OPTION_NULL);
            return;
        }

        HashMap<String, Object> naviOptions =
                (HashMap<String, Object>) argumentsMap.get("routeOption");
        if (null == naviOptions) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        Gson gson = new GsonBuilder().enableComplexMapKeySerialization().create();
        String json = gson.toJson(naviOptions);
        if (TextUtils.isEmpty(json)) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        OpenRouteOptionBean openRouteOptionBean = gson.fromJson(json, OpenRouteOptionBean.class);
        openBaiduNaviImp(openRouteOptionBean, result);
    }

    private void openBaiduNaviImp(OpenRouteOptionBean openRouteOptionBean,
                                  MethodChannel.Result result) {

        Context applicationContext = FlutterBmfUtilsPlugin.getApplicationContext();
        if (null == applicationContext) {
            returnResult(Constants.ErrorCode.OPEN_OTHER_ERROR);
            return;
        }

        if (null == openRouteOptionBean) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        RouteParaOption routeParaOption = toNaviParaOption(openRouteOptionBean);
        if (null == routeParaOption) {
            returnResult(Constants.ErrorCode.OPTION_ERROR);
            return;
        }

        BaiduMapRoutePlan.setSupportWebRoute(openRouteOptionBean.isSupportWeb);
        boolean ret = false;
        try {
            switch (openRouteOptionBean.routeType) {
                case Constants.RouteType.sWalkingRoute:
                    ret = BaiduMapRoutePlan
                            .openBaiduMapWalkingRoute(routeParaOption, applicationContext);
                    break;
                case Constants.RouteType.sDrivingRoute:
                    ret = BaiduMapRoutePlan
                            .openBaiduMapDrivingRoute(routeParaOption, applicationContext);
                    break;
                case Constants.RouteType.sTransitRoute:
                    ret = BaiduMapRoutePlan
                            .openBaiduMapTransitRoute(routeParaOption, applicationContext);
                    break;
                default:
                    break;
            }
        } catch (Exception e) {
            Log.e(TAG, e.toString());
        }

        if (true == ret) {
            returnResult(Constants.ErrorCode.OPEN_NO_ERROR);
        } else {
            returnResult(Constants.ErrorCode.OPEN_OTHER_ERROR);
        }
    }

    private RouteParaOption toNaviParaOption(OpenRouteOptionBean openRouteOptionBean) {
        if (null == openRouteOptionBean) {
            return null;
        }

        RouteParaOption routeParaOption = new RouteParaOption();
        routeParaOption.busStrategyType(correctBusStrategy(openRouteOptionBean.transitPolicy));
        routeParaOption.startName(openRouteOptionBean.startName);
        routeParaOption.endName(openRouteOptionBean.endName);
        routeParaOption.startPoint(openRouteOptionBean.startCoord);
        routeParaOption.endPoint(openRouteOptionBean.endCoord);

        return routeParaOption;
    }

    /**
     * flutter传过来的BusStrategy 与android端不一致，需要进行修正
     */
    private RouteParaOption.EBusStrategyType correctBusStrategy(int transitPolicy) {
        transitPolicy -= 3;
        if (0 == transitPolicy) {
            transitPolicy = 4;
        } else if (4 == transitPolicy) {
            transitPolicy = 0;
        }

        return RouteParaOption.EBusStrategyType.values()[transitPolicy];
    }
}