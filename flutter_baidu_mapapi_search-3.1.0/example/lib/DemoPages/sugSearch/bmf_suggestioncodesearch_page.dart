import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
// import 'package:flutter_baidu_mapapi_base/map/bmf_models.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';

class BMFSugSearchPage extends StatelessWidget {
  const BMFSugSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: 'sug检索',
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
          child: new Text("百度地图sug检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFSuggestionSearchOption suggestionSearchOption =
                BMFSuggestionSearchOption(keyword: '中关村', cityname: '北京');

            /// 检索实例
            BMFSuggestionSearch suggestionSearch = BMFSuggestionSearch();

            /// 检索回调
            suggestionSearch.onGetSuggestSearchResult(callback:
                (BMFSuggestionSearchResult result,
                    BMFSearchErrorCode errorCode) {
              print(
                  ' sug检索回调 result = ${result.toMap()} \n errorCode = ${errorCode}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag =
                await suggestionSearch.suggestionSearch(suggestionSearchOption);

            print('flag = $flag');
          })
    ]);
  }
}
