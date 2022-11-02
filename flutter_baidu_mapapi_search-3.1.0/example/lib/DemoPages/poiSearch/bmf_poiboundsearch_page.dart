import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFPoiBoundSearchPage extends StatelessWidget {
  const BMFPoiBoundSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'poi矩形检索',
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
          child: new Text("百度地图poi矩形检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFPoiBoundSearchOption poiBoundSearchOption =
                BMFPoiBoundSearchOption(
                    keywords: <String>['小吃'],
                    leftBottom: BMFCoordinate(40.049557, 116.279295),
                    rightTop: BMFCoordinate(40.056057, 116.308102));

            /// 检索实例
            BMFPoiBoundSearch boundSearch = BMFPoiBoundSearch();

            /// 检索回调
            boundSearch.onGetPoiBoundsSearchResult(callback:
                (BMFPoiSearchResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' poi矩形检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
            });

            /// 发起检索
            bool flag = await boundSearch.poiBoundsSearch(poiBoundSearchOption);

            print('flag = $flag');
          })
    ]);
  }
}
