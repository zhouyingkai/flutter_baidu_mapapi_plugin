import 'package:flutter/services.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_bmfbase');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await FlutterBmfbase.platformVersion, '42');
  // });

  test('BMFCoordinate null safe test 1', () {
    // var coord = BMFCoordinate(null, null);
  });

  test('BMFCoordinate null safe test 2', () {
    Map map = {"x": 40.057038, "y": 116.307899};
    BMFCoordinate.fromMap(map);
  });

  test('BMFCoordinate null safe test 3', () {
    Map map = {"latitude": 40.057038, "longitude": null};
    BMFCoordinate.fromMap(map);
  });

  test('BMFCoordinate null safe test 4', () {
    Map map = {"latitude": 40.057038, "longitude": 116.307899};
    var coord = BMFCoordinate.fromMap(map);
    expect(coord.latitude, 40.057038);
    expect(coord.longitude, 116.307899);
  });

  test('BMFCoordinate null safe test 5', () {
    double? lat;
    double? lon;
    var coord = BMFCoordinate(lat ?? 0.0, lon ?? 0.0);
    expect(coord.latitude, 0.0);
    expect(coord.longitude, 0.0);
  });
}
