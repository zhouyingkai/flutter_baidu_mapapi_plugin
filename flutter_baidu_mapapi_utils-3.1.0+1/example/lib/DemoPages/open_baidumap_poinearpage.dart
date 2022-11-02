import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/map_appbar.dart';

class OpenBaiduMapPoiNearPage extends StatelessWidget {
  const OpenBaiduMapPoiNearPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '调起百度地图客户端Poi周边示例',
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
          child: new Text("启动百度地图Poi周边（Native）"),
          onPressed: () {
            onOpenBaiduMapPoiNear();
          })
    ]);
  }
}

void onOpenBaiduMapPoiNear() async {
  BMFOpenPoiNearOption poiNearOption = BMFOpenPoiNearOption(
      location: BMFCoordinate(40.056858, 116.308194),
      radius: 500,
      keyword: '小吃',
      appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com',
      isSupportWeb: true);
  BMFOpenErrorCode? flag =
      await BMFOpenMapUtils.openBaiduMapPoiNear(poiNearOption);
  print('open - poinear - errorCode = $flag');
}
