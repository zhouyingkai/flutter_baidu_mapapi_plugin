import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/map_appbar.dart';

class CoordTypeConvertPage extends StatefulWidget {
  CoordTypeConvertPage({Key? key}) : super(key: key);

  @override
  _CoordTypeConvertPageState createState() => _CoordTypeConvertPageState();
}

class _CoordTypeConvertPageState extends State<CoordTypeConvertPage> {
  ///原始经度
  double _srcLongitude = 0;

  /// 原始纬度
  double _srcLatitude = 0;

  /// 目标经度
  double _destLongitude = 0;

  /// 目标纬度
  double _destLatitude = 0;

  BMF_COORD_TYPE _srcSelectType = BMF_COORD_TYPE.GPS;
  BMF_COORD_TYPE _destSelectType = BMF_COORD_TYPE.GPS;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: BMFAppBar(
          title: '坐标转换示例',
          onBack: () {
            Navigator.pop(context);
          },
        ),
        body: Container(child: generateBody()),
      ),
    );
  }

  Column generateBody() {
    return Column(
      children: <Widget>[
        generateSrcCoordRow(),
        generateDestCoordRow(),
        generateSelectCoordTypeRow(),
        generateTips(),
        TextButton(
            child: Text("转换"),
            onPressed: () {
              convert();
            }),
      ],
    );
  }

  Row generateSrcCoordRow() {
    return Row(
      children: <Widget>[
        Text("原始坐标: 经度:"),
        Expanded(
            child: TextField(
                keyboardType: TextInputType.multiline,
                onChanged: (str) => getSrcLongitude(str))),
        Text('纬度:'),
        Expanded(
            child: TextField(
                keyboardType: TextInputType.multiline,
                onChanged: (str) => getSrclatitude(str))),
      ],
    );
  }

  Row generateDestCoordRow() {
    return Row(
      children: <Widget>[
        Text("目标坐标: 经度:"),
        Expanded(child: Text(_destLongitude.toString())),
        Text('纬度:'),
        Expanded(child: Text(_destLatitude.toString()))
      ],
    );
  }

  Row generateSelectCoordTypeRow() {
    return Row(
      children: <Widget>[
        Text("源坐标:"),
        DropdownButton(
          items: [
            new DropdownMenuItem(
              child: new Text('GPS坐标'),
              value: BMF_COORD_TYPE.GPS,
            ),
            new DropdownMenuItem(
              child: new Text('GCJ坐标'),
              value: BMF_COORD_TYPE.COMMON,
            ),
            new DropdownMenuItem(
              child: new Text('百度经纬度坐标'),
              value: BMF_COORD_TYPE.BD09LL,
            ),
          ],
          onChanged: (value) {
            BMF_COORD_TYPE toType = getDestCoordType(value as BMF_COORD_TYPE);
            setState(() {
              _srcSelectType = value;
              _destSelectType = toType;
            });
          },
          value: _srcSelectType,
        ),
        Text("目标坐标:"),
        DropdownButton(
          items: [
            new DropdownMenuItem(
              child: new Text('GPS坐标'),
              value: BMF_COORD_TYPE.GPS,
            ),
            new DropdownMenuItem(
              child: new Text('GCJ坐标'),
              value: BMF_COORD_TYPE.COMMON,
            ),
            new DropdownMenuItem(
              child: new Text('百度经纬度坐标'),
              value: BMF_COORD_TYPE.BD09LL,
            ),
          ],
          onChanged: (value) {
            if (Platform.isAndroid) {
              return;
            }

            setState(() {
              _destSelectType = value as BMF_COORD_TYPE;
            });
          },
          value: _destSelectType,
        )
      ],
    );
  }

  Text generateTips() {
    if (!Platform.isAndroid) {
      return Text('');
    }

    return Text(
      'Android 平台只需要指定源坐标',
      style: TextStyle(color: Colors.red, fontSize: 10),
    );
  }

  ///纬度
  void getSrclatitude(String str) {
    BMFLog.d(str);
    _srcLatitude = double.parse(str);
  }

  ///经度
  void getSrcLongitude(String str) {
    _srcLongitude = double.parse(str);
    BMFLog.d(_srcLongitude.toString());
  }

  Future<void> convert() async {
    // BMFCoordinate coo0 = BMFCoordinate(39.965, 116.304);
    // BMFCoordinate coo1 = BMFCoordinate(39.865, 116.304);
    // BMFCoordinate coo3 = BMFCoordinate(39.865, 116.404);
    // BMFCoordinate coor4 = BMFCoordinate(39.905, 116.354);

    /// 矩形面积计算
    // BMFCoordinate coo0 = BMFCoordinate(40.091215711, 116.179407097);
    // BMFCoordinate coo1 = BMFCoordinate(42.091215711, 118.179407097);
    // Future<double> arfuture =
    //     BMFCalculateUtils.areaBetweenCoordinatesDispatcher(coo0, coo1);

    // arfuture.then((onValue) {
    //   BMFLog.d('area = ' + onValue.toString());
    // });

    /// polygon面积计算
    // List<BMFCoordinate> coords = new List();
    // coords.add(coo0);
    // coords.add(coo1);
    // coords.add(coo3);
    // Future<double> arfuture =
    //     BMFCalculateUtils.calculatePolygonArea(coords);
    // arfuture.then((onValue) {
    //   BMFLog.d('polygon.area = ' + onValue.toString());
    // });

    /// 两点间的距离
    // Future<double> arfuture = BMFCalculateUtils.getLocationDistance(coo0, coo1);
    // arfuture.then((onValue) {
    //   BMFLog.d('distance:' + onValue.toString());
    // });

    /// 点与线最近点
    // Future<BMFCoordinate> arfuture =
    //     BMFCalculateUtils.getNearestPointToLine(coords, coor4);
    // arfuture.then((onValue) {
    //   BMFLog.d('point:' + '${onValue.toMap()}');
    // });

    /// 点到折线的垂足
    // Future<BMFCoordinate> arfuture =
    //     BMFCalculateUtils.getPointToTheVerticalFootOfLine(coo0, coo1, coo3);
    // arfuture.then((onValue) {
    //   BMFLog.d('footCoord : ' + '${onValue.toMap()}');
    // });

    /// 点是否包含在polygon
    // Future<bool> arfuture =
    //     BMFCalculateUtils.polygonContainsCoordinate(coo0, coords);
    // arfuture.then((onValue) {
    //   BMFLog.d('point in polygon : ' + onValue.toString());
    // });

    /// 点是否在circle内
    // Future<bool> arfuture =
    //     BMFCalculateUtils.circleContainsCoordinate(coo1, coo1, 10);
    // arfuture.then((onValue) {
    //   BMFLog.d('point in circle : ' + onValue.toString());
    // });

    /// 两点的方向
    // Future<double> arfuture =
    //     BMFCalculateUtils.getDirectionFromCoords(coo0, coo1);
    // arfuture.then((onValue) {
    //   BMFLog.d('direction : ' + onValue.toString());
    // });

    /// 坐标转换
    BMFCoordinate coordinate = BMFCoordinate(_srcLatitude, _srcLongitude);
    BMFLog.d(coordinate);

    Future<BMFCoordinate?> future;

    if (Platform.isAndroid) {
      future = BMFCalculateUtils.coordConvert(
          coordinate: coordinate, fromType: _srcSelectType);
    } else {
      future = BMFCalculateUtils.coordConvert(
          coordinate: coordinate,
          fromType: _srcSelectType,
          toType: _srcSelectType);
    }

    await future.then((value) {
      if (value is BMFCoordinate) {
        setState(() {
          _destLatitude = value.latitude;
          _destLongitude = value.longitude;
        });
      }
    });
  }

  BMF_COORD_TYPE getDestCoordType(BMF_COORD_TYPE fromType) {
    if (!Platform.isAndroid) {
      return _destSelectType;
    }

    BMF_COORD_TYPE toType = BMF_COORD_TYPE.BD09LL;
    switch (fromType) {
      case BMF_COORD_TYPE.GPS:
      case BMF_COORD_TYPE.COMMON:
        toType = BMF_COORD_TYPE.BD09LL;
        break;
      case BMF_COORD_TYPE.BD09LL:
        toType = BMF_COORD_TYPE.COMMON;
        break;
      default:
        break;
    }

    return toType;
  }
}
