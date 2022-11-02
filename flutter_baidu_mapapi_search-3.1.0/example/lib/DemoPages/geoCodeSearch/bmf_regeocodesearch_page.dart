import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFReGeoCodeSearchPage extends StatefulWidget {
  BMFReGeoCodeSearchPage({Key? key}) : super(key: key);

  @override
  _BMFReGeoCodeSearchPageState createState() => _BMFReGeoCodeSearchPageState();
}

class _BMFReGeoCodeSearchPageState extends State<BMFReGeoCodeSearchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '逆地理编码',
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
          child: new Text("逆地理编码"),
          onPressed: () async {
            /// 构造检索参数
            BMFReverseGeoCodeSearchOption reverseGeoCodeSearchOption =
                BMFReverseGeoCodeSearchOption(
                    location: BMFCoordinate(40.049850, 116.279920));

            /// 检索实例
            BMFReverseGeoCodeSearch reverseGeoCodeSearch =
                BMFReverseGeoCodeSearch();

            /// 逆地理编码回调
            reverseGeoCodeSearch.onGetReverseGeoCodeSearchResult(callback:
                (BMFReverseGeoCodeSearchResult result,
                    BMFSearchErrorCode errorCode) {
              print(
                  ' 逆地理编码  errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发送检索
            bool flag = await reverseGeoCodeSearch
                .reverseGeoCodeSearch(reverseGeoCodeSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
