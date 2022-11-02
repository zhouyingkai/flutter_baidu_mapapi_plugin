import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/map_appbar.dart';

class OpenBaiduMapPoiDetailPage extends StatelessWidget {
  const OpenBaiduMapPoiDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '调起百度地图客户端Poi详情示例',
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
          child: new Text("启动百度地图Poi详情（Native）"),
          onPressed: () {
            onOpenBaiduMapPoiDetail();
          })
    ]);
  }
}

void onOpenBaiduMapPoiDetail() async {
  BMFOpenPoiDetailOption poiDetailOption = BMFOpenPoiDetailOption(
      poiUid: '61de9e42100f17f0611809de',
      appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com',
      isSupportWeb: true);
  BMFOpenErrorCode? flag =
      await BMFOpenMapUtils.openBaiduMapPoiDetail(poiDetailOption);
  print('open - poidetail - errorCode = $flag');
}
