import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/map_appbar.dart';

class OpenBaiduMapNaviPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '调起百度地图客户端导航示例',
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
          child: new Text("启动百度地图导航（Native）"),
          onPressed: () {
            onOpenBaiduNaviNative();
          })
    ]);
  }

  void onOpenBaiduNaviNative() async {
    print("onOpenBaiduNaviNative enter");

    // 天安门坐标
    BMFCoordinate coordinate1 = BMFCoordinate(39.915291, 116.403857);
    String startName = "天安门";
    // 百度大厦坐标
    String endName = "百度大厦";
    BMFCoordinate coordinate2 = BMFCoordinate(40.056858, 116.308194);

    BMFOpenNaviOption naviOption = BMFOpenNaviOption(
        startCoord: coordinate1,
        endCoord: coordinate2,
        startName: startName,
        endName: endName,
        naviType: BMFNaviType.ARWalkNavi,
        appScheme: 'baidumapsdk_flutter://mapsdk.baidu.com', // 指定返回自定义scheme
        appName: 'baidumap', // 应用名称
        isSupportWeb:
            false); // 调起百度地图客户端驾车导航失败后（步行、骑行导航设置该参数无效），是否支持调起web地图，默认：true

    BMFOpenErrorCode? flag = await BMFOpenMapUtils.openBaiduMapNavi(naviOption);
    print('open - navi - errorCode = $flag');
  }
}
