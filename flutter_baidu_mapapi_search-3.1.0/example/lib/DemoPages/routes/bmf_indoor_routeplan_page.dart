import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFIndoorRoutePlanPage extends StatelessWidget {
  const BMFIndoorRoutePlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '室内路线检索',
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
          child: new Text("百度地图室内路线检索"),
          onPressed: () async {
            /// 构造检索参数
            // 规划路线
            BMFIndoorPlanNode from = BMFIndoorPlanNode(
                floor: 'F1',
                pt: BMFCoordinate(39.917381286621094, 116.37978363037109));
            BMFIndoorPlanNode to = BMFIndoorPlanNode(
                floor: 'F6',
                pt: BMFCoordinate(39.917240142822266, 116.37954711914063));

            BMFIndoorRoutePlanOption indoorRoutePlanOption =
                BMFIndoorRoutePlanOption(from: from, to: to);

            /// 检索实例
            BMFIndoorRouteSearch indoorRouteSearch = BMFIndoorRouteSearch();

            /// 检索回调
            indoorRouteSearch.onGetIndoorRouteSearchResult(callback:
                (BMFIndoorRouteResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 室内路线检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await indoorRouteSearch
                .indoorRouteSearch(indoorRoutePlanOption);

            print('flag = $flag');
          })
    ]);
  }
}
