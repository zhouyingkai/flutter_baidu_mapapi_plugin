import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_map_example/CustomWidgets/map_appbar.dart';
import 'package:flutter_baidu_mapapi_map_example/constants.dart';

class DrawTraceOverlayPage extends StatefulWidget {
  DrawTraceOverlayPage({Key? key}) : super(key: key);

  @override
  _DrawTraceOverlayPageState createState() => _DrawTraceOverlayPageState();
}

class _DrawTraceOverlayPageState extends State<DrawTraceOverlayPage> {
  late BMFMapController myMapController;
  late Size screenSize;

  late BMFTraceOverlay _traceOverlay;
  late bool _addState = false;
  late String _btnText = "删除";

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    myMapController = controller;
    _addTraceOverlay();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: "动态轨迹",
          onBack: () {
            Navigator.pop(context);
          },
        ),
        body: Stack(
          children: [
            generateMap(),
            generateControlBar(),
          ],
        ),
      ),
    );
  }

  Widget generateControlBar() {
    return Container(
      width: screenSize.width,
      height: 60,
      color: Color(int.parse(Constants.controlBarColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(
              _btnText,
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Color(int.parse(Constants.btnColor))),
            ),
            onPressed: () {
              onBtnPress();
            },
          )
        ],
      ),
    );
  }

  /// 创建地图
  Container generateMap() {
    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: BMFMapWidget(
        onBMFMapCreated: (controller) {
          onBMFMapCreated(controller);
        },
        mapOptions: BMFMapOptions(
            center: BMFCoordinate(40.048997, 116.309648), zoomLevel: 16),
      ),
    );
  }

  Future<void> _addTraceOverlay() async {
    /// 读取动态轨迹点
    String coordinateStrings =
        await rootBundle.loadString('resoures/trace_path.txt');

    /// string -> list
    List<String> coordinateStringList = coordinateStrings.split(',');

    /// 动态轨迹点
    List<BMFCoordinate> coords = [];
    for (var i = 0; i < coordinateStringList.length; i += 2) {
      BMFCoordinate coordinate = BMFCoordinate(
          double.parse(coordinateStringList[i + 1]),
          double.parse(coordinateStringList[i]));
      coords.add(coordinate);
    }

    /// 构造动态轨迹动画参数
    BMFTraceOverlayAnimateOption traceOverlayAnimateOption =
        BMFTraceOverlayAnimateOption(
            animate: true,
            delay: 0.0,
            duration: 3,
            fromValue: 0.0,
            toValue: 1.0,
            easingCurve: BMFTraceOverlayAnimationEasingCurve.Linear,
            trackMove: true);

    /// 构造动态轨迹
    _traceOverlay = BMFTraceOverlay(
        coordinates: coords,
        traceOverlayAnimateOption: traceOverlayAnimateOption);
    await myMapController.addTraceOverlay(_traceOverlay);
  }

  void _removeTraceOverlay() {
    myMapController.removeTraceOverlay(_traceOverlay.Id);
  }

  void onBtnPress() {
    if (_addState) {
      _addTraceOverlay();
    } else {
      _removeTraceOverlay();
    }
    _addState = !_addState;
    setState(() {
      _btnText = _addState == true ? "添加" : "删除";
    });
  }
}
