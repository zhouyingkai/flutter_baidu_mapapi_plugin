import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFDistrictSearchPage extends StatelessWidget {
  const BMFDistrictSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '行政区域检索',
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
          child: new Text("百度地图行政区域检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFDistrictSearchOption districtSearchOption =
                BMFDistrictSearchOption(city: '北京', district: '海淀区');

            /// 检索实例
            BMFDistrictSearch districtSearch = BMFDistrictSearch();

            /// 检索回调
            districtSearch.onGetDistrictSearchResult(callback:
                (BMFDistrictSearchResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 行政检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag =
                await districtSearch.districtSearch(districtSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
