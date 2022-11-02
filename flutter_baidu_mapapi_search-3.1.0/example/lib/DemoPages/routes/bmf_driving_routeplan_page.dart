import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFDrivingRoutePlanPage extends StatelessWidget {
  const BMFDrivingRoutePlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '驾车检索',
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
          child: new Text("百度地图驾车路线检索"),
          onPressed: () async {
            // 经纬度规划路线
            // BMFPlanNode from = BMFPlanNode(pt: BMFCoordinate(40.056056,116.308102));
            // BMFPlanNode to = BMFPlanNode(pt: BMFCoordinate(40.059036,116.312555));

            /// 构造检索参数
            // 地名规划路线
            BMFPlanNode from = BMFPlanNode(cityName: '北京', name: '百度大厦');
            BMFPlanNode to = BMFPlanNode(cityName: '北京', name: '清华大学');
            // 驾车检索参数设置
            BMFDrivingRoutePlanOption drivingRoutePlanOption =
                BMFDrivingRoutePlanOption(from: from, to: to);
            BMFDrivingRouteSearch drivingRouteSearch = BMFDrivingRouteSearch();

            /// 检索回调
            drivingRouteSearch.onGetDrivingRouteSearchResult(callback:
                (BMFDrivingRouteResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 驾车检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await drivingRouteSearch
                .dringRouteSearch(drivingRoutePlanOption);
            print('flag = $flag');
          })
    ]);
  }
}
