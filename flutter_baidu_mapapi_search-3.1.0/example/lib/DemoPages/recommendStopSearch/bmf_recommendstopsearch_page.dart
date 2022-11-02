import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate;
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFRecommendStopSearchPage extends StatelessWidget {
  const BMFRecommendStopSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '推荐上车点检索',
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
          child: new Text("百度地图推荐上车点检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFRecommendStopSearchOption recommendStopSearchOption =
                BMFRecommendStopSearchOption(
                    location: BMFCoordinate(40.047471, 116.31372));

            /// 检索实例
            BMFRecommendStopSearch recommendStopSearch =
                BMFRecommendStopSearch();

            /// 检索回调
            recommendStopSearch.onGetRecommendStopSearchResult(callback:
                (BMFRecommendStopSearchResult result,
                    BMFSearchErrorCode errorCode) {
              print(
                  ' 推荐上车点检索回调 result = ${result.toMap()} \n errorCode = ${errorCode}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await recommendStopSearch
                .recommendStopSearch(recommendStopSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
