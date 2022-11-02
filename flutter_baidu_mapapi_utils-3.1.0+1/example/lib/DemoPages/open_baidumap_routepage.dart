import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/map_appbar.dart';

class OpenBaiduMapRoutePage extends StatelessWidget {
  const OpenBaiduMapRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '调起百度地图客户端路线规划示例',
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
          child: new Text("启动百度地图路线规划（Native）"),
          onPressed: () {
            onOpenBaiduMapRoute();
          })
    ]);
  }
}

void onOpenBaiduMapRoute() async {
  // 天安门坐标
  BMFCoordinate startCoord = BMFCoordinate(39.915291, 116.403857);
  String startName = "天安门";
  // 百度大厦坐标
  String endName = "百度大厦";
  BMFCoordinate endCoord = BMFCoordinate(40.05685, 116.308194);
  BMFOpenRouteOption routeOption = BMFOpenRouteOption(
      startCoord: startCoord,
      startName: startName,
      endCoord: endCoord,
      endName: endName,
      routeType: BMFOpenRouteType.WalkingRoute,
      appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com', // 指定返回自定义scheme
      isSupportWeb: true);
  BMFOpenErrorCode? flag = await BMFOpenMapUtils.openBaiduMapRoute(routeOption);
  print('open - route - errorCode = $flag');
}
