import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFBuslineSearchPage extends StatelessWidget {
  const BMFBuslineSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '公交线路检索',
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
          child: new Text("百度地图公交线路检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFBusLineSearchOption busLineSearchOption = BMFBusLineSearchOption(
                busLineUid: '566982672f9427deb23c814d', city: '北京');

            /// 检索实例
            BMFBusLineSearch buslineSearch = BMFBusLineSearch();

            /// 检索回调
            buslineSearch.onGetBuslineSearchResult(callback:
                (BMFBusLineResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 公交检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await buslineSearch.busLineSearch(busLineSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
