import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFPoiDetailSearchPage extends StatelessWidget {
  const BMFPoiDetailSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'poi详情检索',
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
          child: new Text("百度地图poi详情检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFPoiDetailSearchOption poiDetailSearchOption =
                BMFPoiDetailSearchOption(
                    scope: BMFPoiSearchScopeType.DETAIL_INFORMATION,
                    poiUIDs: <String>['e96b44200baa3b4082288acc']);

            /// 检索实例
            BMFPoiDetailSearch poiDetailSearch = BMFPoiDetailSearch();

            /// 检索回调
            poiDetailSearch.onGetPoiDetailSearchResult(callback:
                (BMFPoiDetailSearchResult result,
                    BMFSearchErrorCode errorCode) {
              print(
                  ' poi详情检索回调 errorCode = ${errorCode}  \n result = ${result.toMap()}');
            });

            /// 发起检索
            bool flag =
                await poiDetailSearch.poiDetailSearch(poiDetailSearchOption);
            print('flag = $flag');
          })
    ]);
  }
}
