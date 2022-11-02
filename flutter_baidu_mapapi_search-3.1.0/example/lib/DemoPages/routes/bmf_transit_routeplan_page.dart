import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
// import 'package:flutter_baidu_mapapi_base/map/bmf_models.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFTransitRoutePlanPage extends StatelessWidget {
  const BMFTransitRoutePlanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '市内公交检索',
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
          child: new Text("百度地图市内公交检"),
          onPressed: () async {
            /// 构造检索参数
            // 规划路线
            BMFPlanNode from = BMFPlanNode(name: '百度科技园');
            BMFPlanNode to = BMFPlanNode(name: '清华大学');
            BMFTransitRoutePlanOption transitRoutePlanOption =
                BMFTransitRoutePlanOption(from: from, to: to, city: '北京市');

            /// 检索实例
            BMFTransitRouteSearch transitRouteSearch = BMFTransitRouteSearch();

            /// 检索回调
            transitRouteSearch.onGetTransitRouteSearchResult(callback:
                (BMFTransitRouteResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 市内公交检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await transitRouteSearch
                .transitRouteSearch(transitRoutePlanOption);

            print('flag = $flag');
          })
    ]);
  }
}
