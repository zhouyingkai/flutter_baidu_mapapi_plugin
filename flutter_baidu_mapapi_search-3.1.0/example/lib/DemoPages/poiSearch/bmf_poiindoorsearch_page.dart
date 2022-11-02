import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFPoiIndoorSearchPage extends StatelessWidget {
  const BMFPoiIndoorSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'poi室内检索',
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
          child: new Text("百度地图poi室内检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFPoiIndoorSearchOption poiIndoorSearchOption =
                BMFPoiIndoorSearchOption(
                    indoorID: '1266498491660632063', keyword: '小吃', floor: '');

            /// 检索实例
            BMFPoiIndoorSearch poiIndoorSearch = BMFPoiIndoorSearch();

            /// 检索回调
            poiIndoorSearch.onGetPoiIndoorSearchearchResult(callback:
                (BMFPoiIndoorSearchResult result,
                    BMFSearchErrorCode errorCode) {
              print(
                  ' poi室内检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
            });

            /// 发起检索
            bool flag =
                await poiIndoorSearch.poiIndoorSearch(poiIndoorSearchOption);

            print('flag = $flag');
          })
    ]);
  }
}
