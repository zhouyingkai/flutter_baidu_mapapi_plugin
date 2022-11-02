import 'dart:io';

import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFLog, BMFMapSDK, BMF_COORD_TYPE;
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_bmflocation_example/location/circleGeofencePage.dart';
import 'package:flutter_bmflocation_example/location/headingLocationPage.dart';
import 'package:flutter_bmflocation_example/location/seriesLocationPage.dart';
import 'package:flutter_bmflocation_example/location/singleLocationPage.dart';
import 'package:flutter_bmflocation_example/widgets/function_item.widget.dart';
import 'package:flutter_bmflocation_example/widgets/loc_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import 'location/polygonGeofencePage.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();

    /// 动态申请定位权限
    requestPermission();



    if (Platform.isIOS) {
      /// 设置ios端ak, android端ak可以直接在清单文件中配置
      myLocPlugin.authAK('d2Xh8XkGOIkTGWqxbDUPT2RbNRjFHGwd');
      BMFMapSDK.setApiKeyAndCoordType(
          'd2Xh8XkGOIkTGWqxbDUPT2RbNRjFHGwd', BMF_COORD_TYPE.BD09LL);
    } else if (Platform.isAndroid) {
      // Android 目前不支持接口设置Apikey,
      // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    }


    myLocPlugin.getApiKeyCallback(callback: (String result) {
      String str = result;
      print('鉴权结果：' + str);
    });

    /// 设置是否隐私政策
    /// 隐私政策官网链接：https://lbsyun.baidu.com/index.php?title=openprivacy
    /// 通知用户之后根据用户选择进行赋值
    myLocPlugin.setAgreePrivacy(true);
    BMFMapSDK.setAgreePrivacy(true);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
          appBar: BMFAppBar(
            title: '百度地图定位flutter插件demo',
            isBack: false,
          ),
          body: FlutterBMFLoctionDemo()),
    );
  }
}

class FlutterBMFLoctionDemo extends StatelessWidget {
  const FlutterBMFLoctionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const <Widget>[
      FunctionItem(
        label: '单次定位',
        sublabel: 'singleLocationPage',
        target: SingleLocationPage(),
      ),

      ///需要停止定位
      FunctionItem(
        label: '连续定位',
        sublabel: 'seriesLocationPage',
        target: SeriesLocationPage(),
      ),
      FunctionItem(
        label: '圆形地理围栏',
        sublabel: 'circleGeofencePage',
        target: CircleGeofencePage(),
      ),
      FunctionItem(
        label: '多边形地理围栏',
        sublabel: 'polygonGeofencePage',
        target: PolygonGeofencePage(),
      ),
      FunctionItem(
        label: '监听设备朝向',
        sublabel: 'headingLocationPage',
        target: HeadingLocationPage(),
      ),
    ]);
  }

  List<Widget> render(BuildContext context, List children) {
    return ListTile.divideTiles(
        context: context,
        tiles: children.map((dynamic data) {
          return buildListTile(
              context, data["title"], data["subtitle"], data["url"]);
        })).toList();
  }

  Widget buildListTile(
      BuildContext context, String title, String subtitle, String url) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(url);
      },
      isThreeLine: true,
      dense: false,
      leading: null,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.blue.shade600,
      ),
    );
  }
}

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
