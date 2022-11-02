package com.baidu.mapapi.search.utils;

import com.baidu.mapapi.search.core.SearchResult;

import java.util.HashMap;

/**
 * 把错误码转换成与flutter中对应的int类型
 */
public class ParseErrorCode {
    private static ParseErrorCode sInstance;
    private static HashMap<SearchResult.ERRORNO, Integer> errorCodeMap;

    public static ParseErrorCode getInstance() {
        if (null == sInstance) {
            sInstance = new ParseErrorCode();
            putErrorCode();
        }
        return sInstance;
    }

    private static void putErrorCode() {
        errorCodeMap = new HashMap<>();
        errorCodeMap.put(SearchResult.ERRORNO.NO_ERROR, 0);
        errorCodeMap.put(SearchResult.ERRORNO.AMBIGUOUS_KEYWORD, 1);
        errorCodeMap.put(SearchResult.ERRORNO.AMBIGUOUS_ROURE_ADDR, 2);
        errorCodeMap.put(SearchResult.ERRORNO.NOT_SUPPORT_BUS, 3);
        errorCodeMap.put(SearchResult.ERRORNO.NOT_SUPPORT_BUS_2CITY, 4);
        errorCodeMap.put(SearchResult.ERRORNO.RESULT_NOT_FOUND, 5);
        errorCodeMap.put(SearchResult.ERRORNO.ST_EN_TOO_NEAR, 6);
        errorCodeMap.put(SearchResult.ERRORNO.KEY_ERROR, 7);
        errorCodeMap.put(SearchResult.ERRORNO.NETWORK_ERROR, 8);
        errorCodeMap.put(SearchResult.ERRORNO.NETWORK_TIME_OUT, 9);
        errorCodeMap.put(SearchResult.ERRORNO.PERMISSION_UNFINISHED, 10);
        errorCodeMap.put(SearchResult.ERRORNO.POIINDOOR_BID_ERROR, 11);
        errorCodeMap.put(SearchResult.ERRORNO.POIINDOOR_FLOOR_ERROR, 12);
        errorCodeMap.put(SearchResult.ERRORNO.INDOOR_ROUTE_NO_IN_BUILDING, 13);
        errorCodeMap.put(SearchResult.ERRORNO.INDOOR_ROUTE_NO_IN_SAME_BUILDING, 14);
        errorCodeMap.put(SearchResult.ERRORNO.SEARCH_OPTION_ERROR, 15);
        errorCodeMap.put(SearchResult.ERRORNO.SEARCH_SERVER_INTERNAL_ERROR, 16);
        errorCodeMap.put(SearchResult.ERRORNO.NO_ADVANCED_PERMISSION, 18);
        errorCodeMap.put(SearchResult.ERRORNO.NO_DATA_FOR_LATLNG, 19);
        errorCodeMap.put(SearchResult.ERRORNO.INVALID_DISTRICT_ID, 20);
        errorCodeMap.put(SearchResult.ERRORNO.POIINDOOR_SERVER_ERROR, 21);
        errorCodeMap.put(SearchResult.ERRORNO.MASS_TRANSIT_SERVER_ERROR, 22);
        errorCodeMap.put(SearchResult.ERRORNO.MASS_TRANSIT_OPTION_ERROR, 23);
        errorCodeMap.put(SearchResult.ERRORNO.MASS_TRANSIT_NO_POI_ERROR, 24);
        errorCodeMap.put(SearchResult.ERRORNO.REQUEST_ERROR, 25);
    }

    public int getErrorCode(SearchResult.ERRORNO errorCode) {

        return errorCodeMap.get(errorCode);
    }
//    /**
//     * 把错误码转换成与flutter中对应的int类型
//     *
//     * @param error 检索返回的error
//     *
//     */
//    public int getErrorCode(SearchResult.ERRORNO error) {
//        int errorCode = 0;
//        switch (error) {
//            /**
//             * 检索结果正常返回
//             */
//            case :
//                errorCode = 0;
//                break;
//            /**
//             * 检索词有岐义
//             */
//            case AMBIGUOUS_KEYWORD:
//                errorCode = 1;
//                break;
//            /**
//             * 检索地址有岐义
//             */
//            case AMBIGUOUS_ROURE_ADDR:
//                errorCode = 2;
//                break;
//            /**
//             * 该城市不支持公交搜索
//             */
//            case NOT_SUPPORT_BUS:
//                errorCode = 3;
//                break;
//            /**
//             * 不支持跨城市公交
//             */
//            case NOT_SUPPORT_BUS_2CITY:
//                errorCode = 4;
//                break;
//            /**
//             * 没有找到检索结果
//             */
//            case RESULT_NOT_FOUND:
//                errorCode = 5;
//                break;
//            /**
//             * 起终点太近
//             */
//            case ST_EN_TOO_NEAR:
//                errorCode = 6;
//                break;
//            /**
//             * key有误
//             */
//            case KEY_ERROR:
//                errorCode = 7;
//                break;
//            /**
//             * 网络错误
//             */
//            case NETWORK_ERROR:
//                errorCode = 8;
//                break;
//            /**
//             * 网络超时
//             */
//            case NETWORK_TIME_OUT:
//                errorCode = 9;
//                break;
//            /**
//             * 授权未完成
//             */
//            case PERMISSION_UNFINISHED:
//                errorCode = 10;
//                break;
//            /**
//             * poi室内检索bid错误
//             */
//            case POIINDOOR_BID_ERROR:
//                errorCode = 11;
//                break;
//            /**
//             * poi室内检索floor错误
//             */
//            case POIINDOOR_FLOOR_ERROR:
//                errorCode = 12;
//                break;
//            /**
//             * 室内路线规划起点、终点不在支持室内路径规划的位置，
//             * 包括起终点在室内，但是该室内图不支持路线规划，对于该中场景，
//             * 可以通过判断点是否在室内区分。
//             */
//            case INDOOR_ROUTE_NO_IN_BUILDING:
//                errorCode = 13;
//                break;
//            /**
//             * 室内路线规划起终点不在同一个室内
//             */
//            case INDOOR_ROUTE_NO_IN_SAME_BUILDING:
//                errorCode = 14;
//                break;
//            /**
//             * 参数错误
//             */
//            case SEARCH_OPTION_ERROR:
//                errorCode = 15;
//                break;
//            /**
//             * 服务器内部错误
//             */
//            case SEARCH_SERVER_INTERNAL_ERROR:
//                errorCode = 16;
//                break;
//            /**
//             * poi室内检索服务错误
//             */
//            case POIINDOOR_SERVER_ERROR:
//                errorCode = 17;
//                break;
//            /**
//             * 跨城公共交通服务器内部错误
//             */
//            case MASS_TRANSIT_SERVER_ERROR:
//                errorCode = 18;
//                break;
//            /**
//             * 跨城公共交通错误码：参数无效
//             */
//            case MASS_TRANSIT_OPTION_ERROR:
//                errorCode = 19;
//                break;
//            /**
//             * 跨城公共交通没有匹配的POI
//             */
//            case MASS_TRANSIT_NO_POI_ERROR:
//                errorCode = 20;
//                break;
//            /**
//             * 请求错误
//             */
//            case REQUEST_ERROR:
//                errorCode = 21;
//                break;
//        }
//        return errorCode;
//    }
}
