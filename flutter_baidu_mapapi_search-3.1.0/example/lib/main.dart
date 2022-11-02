import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_search_example/flutter_mapsearch_demo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 设置用户是否同意SDK隐私协议
  BMFMapSDK.setAgreePrivacy(true);

  // 百度地图sdk初始化鉴权
  if (Platform.isIOS) {
    BMFMapSDK.setApiKeyAndCoordType(
        'yFDD3IlfSk2xTdQ0G41MjRnzd5gUVG1C', BMF_COORD_TYPE.BD09LL);
    Map? map = await BMFMapAPI_Search.nativeSearchVersion;
    print('获取原生地图版本号：$map');
  } else if (Platform.isAndroid) {
    // Android 目前不支持接口设置Apikey,
    // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: BMFAppBar(
            title: '百度地图flutter插件searh组件Demo',
            isBack: false,
          ),
          body: BMFMapSearchDemo()),
    );
  }
}
