import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
// import 'package:flutter_baidu_mapapi_base/map/bmf_models.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFWalkingRoutePlanPage extends StatelessWidget {
  const BMFWalkingRoutePlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '步行检索',
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
          child: new Text("百度地图步行路线检索"),
          onPressed: () async {
            // 经纬度规划路线
            // BMFPlanNode from = BMFPlanNode(pt: BMFCoordinate(40.056056,116.308102));
            // BMFPlanNode to = BMFPlanNode(pt: BMFCoordinate(40.059036,116.312555));
            /// 构造检索参数
            // 地名规划路线
            BMFPlanNode from = BMFPlanNode(cityName: '北京', name: '百度大厦');
            BMFPlanNode to = BMFPlanNode(cityName: '北京', name: '西二旗地铁站');
            BMFWalkingRoutePlanOption walkingRoutePlanOption =
                BMFWalkingRoutePlanOption(from: from, to: to);

            /// 检索实例
            BMFWalkingRouteSearch walkingRouteSearch = BMFWalkingRouteSearch();

            /// 检索回调
            walkingRouteSearch.onGetWalkingRouteSearchResult(callback:
                (BMFWalkingRouteResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 步行检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await walkingRouteSearch
                .walkingRouteSearch(walkingRoutePlanOption);
            print('flag = $flag');
          })
    ]);
  }
}
