import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_bmflocation_example/widgets/loc_appbar.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

class PolygonGeofencePage extends StatefulWidget {
  const PolygonGeofencePage({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PolygonGeofencePage> {
  late BMFMapController _myMapController;

  final GeofenceFlutterPlugin _myGeofencePlugin = GeofenceFlutterPlugin();

  String? resultText;

  List<BMFCoordinate> _coordinateList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _removeAllGeoFence();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: BMFAppBar(
        title: '多边形围栏',
        isBack: true,
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(children: [
        _createMapContainer(),
        Container(height: 20),
        Container(
          padding: const EdgeInsets.only(left: 100, right: 100),
        ),
        Container(height: 20),
        Text(resultText ?? '长按地图添加标注'),
        Container(height: 20),
        _createButtonContainer()
      ]),
    ));
  }

  Widget _createMapContainer() {
    return SizedBox(
        height: 300,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            onBMFMapCreated(controller);
          },
          mapOptions: initMapOptions(),
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
                  _addGeofence();
                },
                child: const Text('创建围栏'),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blueAccent, //change background color of button
                  onPrimary: Colors.yellow, //change text color of button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                )),
          ],
        ));
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 12,
        mapPadding: BMFEdgeInsets(top: 0, left: 0, right: 0, bottom: 0));
    return mapOptions;
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    _myMapController = controller;

    /// 地图加载回调
    _myMapController.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });

    /// 长按地图时会回调此接口
    _myMapController.setMapOnLongClickCallback(
        callback: (BMFCoordinate coordinate) {
      /// 创建BMFMarker
      BMFMarker marker = BMFMarker(
          position: BMFCoordinate(coordinate.latitude, coordinate.longitude),
          title: '多边形地理围栏',
          identifier: 'polygonGeofence_marker',
          icon: 'resoures/icon_mark.png');

      /// 添加Marker
      _myMapController.addMarker(marker);
      _coordinateList
          .add(BMFCoordinate(coordinate.latitude, coordinate.longitude));
    });
  }

  //添加地理围栏
  void _addGeofence() {
    if (_coordinateList.length < 3) {
      setState(() {
        resultText = '坐标点必须大于等于3个';
      });
    } else {
      //添加覆盖物
      BMFHollowShape hollowShapePolygon = BMFHollowShape(
          hollowShapeType: BMFHollowShapeType.polygon,
          coordinates: _coordinateList);
      BMFPolygon polygon0 = BMFPolygon(
        coordinates: _coordinateList,
        strokeColor: Colors.orange,
        fillColor: Colors.amber,
        width: 3,
      );
      _myMapController.addPolygon(polygon0);

      LocationPolygonGeofenceOption op = LocationPolygonGeofenceOption(
          coordType: BMFLocationCoordType.bd09ll,
          activateAction: GeofenceActivateAction.geofenceAll,
          customId: 'polygonGeofence_id',
          allowsBackgroundLocationUpdates: true,
          coordinateList: _coordinateList);

      ///添加地理围栏
      _myGeofencePlugin.addPolygonRegion(op.toMap());

      ///地理围栏创建回调
      _myGeofencePlugin.geofenceFinishCallback(
          callback: (BMFGeofence? geofence) {
        ///创建围栏后清空数组
        _coordinateList.clear();

        if (geofence != null) {
          print('创建完成' +
              geofence.geofenceId! +
              geofence.geofenceStyle.toString());
        }
      });

      /**
       * 监听围栏状态发生改变时回调
       * geoFenceRegionStatus:
       * 1:进入围栏  2:围栏内停留超过10分钟  3:离开围栏
       */
      _myGeofencePlugin.didGeoFencesStatusChangedCallback(
          callback: (Map geofenceResult) {
        if (geofenceResult.isNotEmpty) {
          setState(() {
            Map map = geofenceResult['result'];
            int status = map['geoFenceRegionStatus'] as int;
            switch (status) {
              case 1:
                resultText = '进入地理围栏';
                break;
              case 2:
                resultText = '在围栏内停留超过10分钟';
                break;
              case 3:
                resultText = '在地理围栏之外';
                break;
              case 0:
                resultText = '定位失败';
                break;
              default:
            }
          });
        }
      });

      _getAllGeofence();
    }
  }

  ///获取全部地理围栏id
  Future<void> _getAllGeofence() async {
    List? list = await _myGeofencePlugin.getGeofenceIdList();
    // print('getAllGeofence:$list');
  }

  //移除指定id围栏
  void _removeGeoFenceId(String customId) {
    _myGeofencePlugin.removeGeofenceWithId(customId);
    print('removeGeoFenceId:' + customId);
  }

  //移除指定id围栏
  void _removeAllGeoFence() {
    _myGeofencePlugin.removeAllGeofence();
    print('removeAllGeoFenceId');
  }
}
