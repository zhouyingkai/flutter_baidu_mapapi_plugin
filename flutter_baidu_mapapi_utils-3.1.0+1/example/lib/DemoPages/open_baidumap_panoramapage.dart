import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/map_appbar.dart';

class OpenBaiduMapPanoramaPage extends StatelessWidget {
  const OpenBaiduMapPanoramaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '调起百度地图客户端全景图示例',
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
          child: new Text("启动百度地图全景图（Native）"),
          onPressed: () {
            onOpenBaiduMapPanorama();
          })
    ]);
  }
}

void onOpenBaiduMapPanorama() async {
  BMFOpenPanoramaOption panoramaOption = BMFOpenPanoramaOption(
      poiUid: '61de9e42100f17f0611809de',
      appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com',
      isSupportWeb: true);
  BMFOpenErrorCode? flag =
      await BMFOpenMapUtils.openBaiduMapPanorama(panoramaOption);
  print('open - panorama - errorCode = $flag');
}
