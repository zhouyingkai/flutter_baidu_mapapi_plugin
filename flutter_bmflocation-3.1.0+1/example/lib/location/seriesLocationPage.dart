import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_bmflocation_example/widgets/loc_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

class SeriesLocationPage extends StatefulWidget {
  const SeriesLocationPage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<SeriesLocationPage> {
  BaiduLocation _loationResult = BaiduLocation();
  late BMFMapController _myMapController;
  final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();
  bool _suc = false;

  @override
  void initState() {
    super.initState();

    ///接受定位回调
    _myLocPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
      setState(() {
        _loationResult = result;
        _locationFinish();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stopLocation();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> resultWidgets = [];

    if (_loationResult.locTime != null) {
      _loationResult.getMap().forEach((key, value) {
        resultWidgets.add(_resultWidget(key, value));
      });
    }

    return MaterialApp(
        home: Scaffold(
      appBar: BMFAppBar(
        title: '连续定位',
        isBack: true,
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(children: [
        _createMapContainer(),
        Container(height: 20),
        SizedBox(
          height: MediaQuery.of(context).size.height - 500,
          child: ListView(
            children: resultWidgets,
          ),
        ),
        _createButtonContainer()
      ]),
    ));
  }

  Widget _createMapContainer() {
    return SizedBox(
        height: 300,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            _onBMFMapCreated(controller);
          },
          mapOptions: _initMapOptions(),
        ));
  }

  Container _createButtonContainer() {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  ///设置定位参数
                  _locationAction();
                  _startLocation();
                },
                child: const Text('开始定位'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blueAccent, //change background color of button
                  onPrimary: Colors.yellow, //change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                )),
            Container(width: 20),
            ElevatedButton(
                onPressed: () {
                  _stopLocation();
                },
                child: const Text('停止定位'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blueAccent, //change background color of button
                  onPrimary: Colors.yellow, //change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ))
          ],
        ));
  }

  Widget _resultWidget(key, value) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$key:' ' $value'),
          ]),
    );
  }

  void _locationAction() async {
    /// 设置android端和ios端定位参数
    /// android 端设置定位参数
    /// ios 端设置定位参数
    Map iosMap = _initIOSOptions().getMap();
    Map androidMap = _initAndroidOptions().getMap();

    _suc = await _myLocPlugin.prepareLoc(androidMap, iosMap);
    print('设置定位参数：$iosMap');
  }

  /// 设置地图参数
  BaiduLocationAndroidOption _initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
        coorType: 'bd09ll',
        locationMode: BMFLocationMode.hightAccuracy,
        isNeedAddress: true,
        isNeedAltitude: true,
        isNeedLocationPoiList: true,
        isNeedNewVersionRgc: true,
        isNeedLocationDescribe: true,
        openGps: true,
        scanspan: 4000,
        coordType: BMFLocationCoordType.bd09ll);
    return options;
  }

  BaiduLocationIOSOption _initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
        coordType: BMFLocationCoordType.bd09ll,
        BMKLocationCoordinateType: 'BMKLocationCoordinateTypeBMK09LL',
        desiredAccuracy: BMFDesiredAccuracy.best,
        allowsBackgroundLocationUpdates: true,
        pausesLocationUpdatesAutomatically: false);
    return options;
  }

  // /// 启动定位
  Future<void> _startLocation() async {
    _suc = await _myLocPlugin.startLocation();
    print('开始连续定位：$_suc');
  }

  /// 停止定位
  void _stopLocation() async {
    _suc = await _myLocPlugin.stopLocation();
    print('停止连续定位：$_suc');
  }

  ///定位完成添加mark
  void _locationFinish() {
    /// 创建BMFMarker
    BMFMarker marker = BMFMarker(
        position: BMFCoordinate(
            _loationResult.latitude ?? 0.0, _loationResult.longitude ?? 0.0),
        title: 'flutterMaker',
        identifier: 'flutter_marker',
        icon: 'resoures/icon_mark.png');
    print(_loationResult.latitude.toString() +
        _loationResult.longitude.toString());

    /// 添加Marker
    _myMapController.addMarker(marker);

    ///设置中心点
    _myMapController.setCenterCoordinate(
        BMFCoordinate(
            _loationResult.latitude ?? 0.0, _loationResult.longitude ?? 0.0),
        false);
  }

  /// 设置地图参数
  BMFMapOptions _initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 12,
        mapPadding: BMFEdgeInsets(top: 0, left: 0, right: 0, bottom: 0));
    return mapOptions;
  }

  /// 创建完成回调
  void _onBMFMapCreated(BMFMapController controller) {
    _myMapController = controller;

    /// 地图加载回调
    _myMapController.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });
  }
}
