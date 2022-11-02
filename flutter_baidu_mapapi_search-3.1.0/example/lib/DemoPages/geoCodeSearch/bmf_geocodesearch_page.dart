import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFGeoCodeSearchPage extends StatefulWidget {
  BMFGeoCodeSearchPage({Key? key}) : super(key: key);

  @override
  _BMFGeoCodeSearchPageState createState() => _BMFGeoCodeSearchPageState();
}

class _BMFGeoCodeSearchPageState extends State<BMFGeoCodeSearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '正地理编码',
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
          child: new Text("正地理编码"),
          onPressed: () async {
            /// 构造检索参数
            BMFGeoCodeSearchOption geoCodeSearchOption =
                BMFGeoCodeSearchOption(address: '百度大厦', city: "北京");

            /// 检索实例
            BMFGeocodeSearch geocodeSearch = BMFGeocodeSearch();

            /// 正地理编码回调
            geocodeSearch.onGetGeoCodeSearchResult(callback:
                (BMFGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 正地理编码  errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发送检索
            bool flag = await geocodeSearch.geoCodeSearch(geoCodeSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
