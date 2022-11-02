import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
// import 'package:flutter_baidu_mapapi_base/map/bmf_models.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFRidingRoutePlanPage extends StatelessWidget {
  const BMFRidingRoutePlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '骑行检索',
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
          child: new Text("百度地图骑行路线检索"),
          onPressed: () async {
            // 经纬度规划路线
            // BMFPlanNode from = BMFPlanNode(pt: BMFCoordinate(40.056056,116.308102));
            // BMFPlanNode to = BMFPlanNode(pt: BMFCoordinate(40.059036,116.312555));
            /// 构造检索参数
            // 地名规划路线
            BMFPlanNode from = BMFPlanNode(cityName: '北京', name: '百度大厦a座');
            BMFPlanNode to = BMFPlanNode(cityName: '北京', name: '西二旗地铁站');
            BMFRidingRoutePlanOption ridingRoutePlanOption =
                BMFRidingRoutePlanOption(from: from, to: to);

            /// 检索实例
            BMFRidingRouteSearch ridingRouteSearch = BMFRidingRouteSearch();

            /// 检索回调
            ridingRouteSearch.onGetRidingRouteSearchResult(callback:
                (BMFRidingRouteResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 骑行检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await ridingRouteSearch
                .ridingRouteSearch(ridingRoutePlanOption);
            print('flag = $flag');
          })
    ]);
  }
}
