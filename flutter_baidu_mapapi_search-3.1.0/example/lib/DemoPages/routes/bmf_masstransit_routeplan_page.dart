import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFMassTransitRoutePlanPage extends StatelessWidget {
  const BMFMassTransitRoutePlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '跨城公交检索',
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
          child: new Text("百度地图跨城公交路线检索"),
          onPressed: () async {
            /// 构造检索参数
            // 地名规划路线
            BMFPlanNode from = BMFPlanNode(cityName: '北京', name: '百度科技园');
            BMFPlanNode to = BMFPlanNode(cityName: '河北', name: '避暑山庄');
            BMFMassTransitRoutePlanOption massTransitRoutePlanOption =
                BMFMassTransitRoutePlanOption(from: from, to: to);

            /// 检索实例
            BMFMassTransitRouteSearch massTransitRouteSearch =
                BMFMassTransitRouteSearch();

            /// 检索回调
            massTransitRouteSearch.onGetMassTransitRouteSearchResult(callback:
                (BMFMassTransitRouteResult result,
                    BMFSearchErrorCode errorCode) {
              print(
                  ' 跨城公交检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await massTransitRouteSearch
                .massTransitRouteSearch(massTransitRoutePlanOption);
            print('flag = $flag');
          })
    ]);
  }
}
