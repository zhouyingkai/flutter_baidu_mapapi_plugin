import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFPoiCitySearchPage extends StatelessWidget {
  const BMFPoiCitySearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'poi城市检索',
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
          child: new Text("百度地图poi城市检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFPoiCitySearchOption poiCitySearchOption =
                BMFPoiCitySearchOption(city: '北京', keyword: '小吃');

            /// 检索实例
            BMFPoiCitySearch poiCitySearch = BMFPoiCitySearch();

            /// 检索回调
            poiCitySearch.onGetPoiCitySearchResult(callback:
                (BMFPoiSearchResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' poi城市检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
            });

            /// 发起检索
            bool flag = await poiCitySearch.poiCitySearch(poiCitySearchOption);

            print('flag = $flag');
          })
    ]);
  }
}
