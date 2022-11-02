import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_bmflocation_example/widgets/loc_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

class HeadingLocationPage extends StatefulWidget {
  const HeadingLocationPage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HeadingLocationPage> {
  BaiduHeading _headingResult = BaiduHeading();
  late BMFMapController _myMapController;
  final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();
  bool _suc = false;

  @override
  void initState() {
    super.initState();

    _myLocPlugin.updateHeadingCallback(callback: (BaiduHeading result) {
      _headingResult = result;
      setState(() {
        _headingResult = result;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stopHeading();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> resultWidgets = [];

    if (_headingResult.timestamp != null) {
      _headingResult.getMap().forEach((key, value) {
        resultWidgets.add(_resultWidget(key, value));
      });
    }

    return MaterialApp(
        home: Scaffold(
      appBar: BMFAppBar(
        title: '设备朝向',
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
                  _startHeading();
                },
                child: const Text('开始监听'),
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
                  _stopHeading();
                },
                child: const Text('停止监听'),
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

  Future<void> _startHeading() async {
    _suc = await _myLocPlugin.startUpdatingHeading();
  }

  void _stopHeading() async {
    _suc = await _myLocPlugin.stopUpdatingHeading();
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
