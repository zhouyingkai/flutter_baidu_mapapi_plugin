import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';
// import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
// show BMFCoordinate;

class BMFWeatherSearchPage extends StatelessWidget {
  const BMFWeatherSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '天气检索',
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
          child: new Text("百度地图天气检索"),
          onPressed: () async {
            /// 构造检索参数
            BMFWeatherSearchOption weatherSearchOption = BMFWeatherSearchOption(
                location: null,
                districtID: "110108",
                serverType: BMFWeatherServerType.Default,
                dataType: BMFWeatherDataType.Now,
                languageType: BMFLanguageType.Chinese);

            /// 检索实例
            BMFWeatherSearch weatherSearch = BMFWeatherSearch();

            /// 检索回调
            weatherSearch.onGetWeatherSearchResult(callback:
                (BMFWeatherSearchResult result, BMFSearchErrorCode errorCode) {
              print(
                  ' 天气检索回调 result = ${result.toMap()} \n errorCode = ${errorCode}');
              // 解析result，具体参考demo
            });

            /// 发起检索
            bool flag = await weatherSearch.weatherSearch(weatherSearchOption);

            print('flag = $flag');
          })
    ]);
  }
}
