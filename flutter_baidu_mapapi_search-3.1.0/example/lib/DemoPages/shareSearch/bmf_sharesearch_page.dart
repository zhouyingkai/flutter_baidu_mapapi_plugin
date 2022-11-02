import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFShareSearchPage extends StatelessWidget {
  const BMFShareSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '短串分享',
          onBack: () {
            Navigator.pop(context);
          },
        ),
        body: Container(child: generateWidgetColumen()),
      ),
    );
  }

  Column generateWidgetColumen() {
    return Column(children: <Widget>[
      TextButton(
          child: new Text("百度地图短串分享"),
          onPressed: () async {
            // poiDetailShareUrlSearch();
            // reverseGeoShareUrlSearch();
            routePlanShareUrlSearch();
          })
    ]);
  }

  /// poi详情短串分享
  void poiDetailShareUrlSearch() async {
    /// 构造检索参数
    BMFPoiDetailShareURLOption poiDetailShareURLOption =
        BMFPoiDetailShareURLOption(uid: 'ba97895c02a6ddc7f60e775f');

    /// poi详情短串分享检索
    BMFPoiDetailShareUrlSearch poiDetailShareUrlSearch =
        BMFPoiDetailShareUrlSearch();

    /// poi详情短串分享检索信息结果回调
    poiDetailShareUrlSearch.onGetPoiDetailShareURLResult(
        callback: (BMFShareURLResult result, BMFSearchErrorCode errorCode) {
      print(
          ' poi详情短串分享检索信息 result = ${result.toMap()}  \n errorCode = ${errorCode}');
      // 解析result，具体参考demo
    });

    /// 发起检索
    bool flag = await poiDetailShareUrlSearch
        .poiDetailShareUrlSearch(poiDetailShareURLOption);
    print('flag = $flag');
  }

  /// 获取逆地理编码短串分享url
  void reverseGeoShareUrlSearch() async {
    /// 构造检索参数
    BMFReverseGeoShareURLOption reverseGeoShareURLOption =
        BMFReverseGeoShareURLOption(
            location: BMFCoordinate(40.0498500000, 116.2799200000),
            name: '位置检索',
            snippet: '北京市海淀区西北旺东路10号院');

    /// 检索实例
    BMFReverseGeoShareUrlSearch reverseGeoShareUrlSearch =
        BMFReverseGeoShareUrlSearch();

    /// 检索回调
    reverseGeoShareUrlSearch.onGetReverseGeoShareURLResult(
        callback: (BMFShareURLResult result, BMFSearchErrorCode errorCode) {
      print(
          ' 获取逆地理编码短串分享url result = ${result.toMap()}  \n errorCode = ${errorCode}');
      // 解析result，具体参考demo
    });

    /// 发起检索
    bool flag = await reverseGeoShareUrlSearch
        .reverseGeoShareUrlSearch(reverseGeoShareURLOption);
    print('flag = $flag');
  }

  /// 获取路线规划短串分享url
  void routePlanShareUrlSearch() async {
    /// 构造检索参数
    BMFPlanNode start = BMFPlanNode(cityID: 131, name: '百度大厦');
    BMFPlanNode end = BMFPlanNode(cityID: 131, name: '天安门');

    /// 路线规划短串分享检索信息类
    BMFRoutePlanShareURLOption routePlanShareURLOption =
        BMFRoutePlanShareURLOption(
            from: start,
            to: end,
            // cityID: 131,
            // routeIndex: 0,
            routePlanType: BMFRoutePlanShareURLType.DRIVE);

    /// 检索实例
    BMFRoutePlanShareUrlSearch routePlanShareUrlSearch =
        BMFRoutePlanShareUrlSearch();

    /// 检索回调
    routePlanShareUrlSearch.onGetRoutePlanShareURLResult(
        callback: (BMFShareURLResult result, BMFSearchErrorCode errorCode) {
      print(
          ' 获取路线规划短串分享url result = ${result.toMap()}  \n errorCode = ${errorCode}');
      // 解析result，具体参考demo
    });

    /// 发起检索
    bool flag = await routePlanShareUrlSearch
        .routePlanShareUrlSearch(routePlanShareURLOption);
    print('flag = $flag');
  }
}
