import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFCoordinate;
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFBuildingSearchPage extends StatelessWidget {
  const BMFBuildingSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '地图建筑物检索',
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
          child: new Text("百度地图地图建筑物检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFBuildingSearchOption buildingSearchOption =
                BMFBuildingSearchOption(
                    location: BMFCoordinate(23.02738, 113.748139));

            /// 检索实例
            BMFBuildingSearch buildingSearch = BMFBuildingSearch();

            /// 检索回调
            buildingSearch.onGetBuildingSearchResult(callback:
                (BMFBuildingSearchResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 地图建筑物检索回调 result = ${result.toMap()} \n errorCode = ${errorCode}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag =
                await buildingSearch.buildingSearch(buildingSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
