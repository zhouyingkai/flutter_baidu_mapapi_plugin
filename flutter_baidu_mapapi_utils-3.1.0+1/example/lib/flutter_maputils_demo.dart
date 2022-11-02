import 'package:flutter/cupertino.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/function_group.widget.dart';
import 'package:flutter_baidu_mapapi_utils_example/CustomWidgets/function_item.widget.dart';
import 'package:flutter_baidu_mapapi_utils_example/DemoPages/calc_coord_type_convert_page.dart';
import 'package:flutter_baidu_mapapi_utils_example/DemoPages/open_baidumap_navipage.dart';
import 'package:flutter_baidu_mapapi_utils_example/DemoPages/open_baidumap_panoramapage.dart';
import 'package:flutter_baidu_mapapi_utils_example/DemoPages/open_baidumap_poidetailpage.dart';
import 'package:flutter_baidu_mapapi_utils_example/DemoPages/open_baidumap_poinearpage.dart';
import 'package:flutter_baidu_mapapi_utils_example/DemoPages/open_baidumap_routepage.dart';

class FlutterBMFMapDemo extends StatelessWidget {
  const FlutterBMFMapDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          FunctionGroup(
            headLabel: '实用工具',
            children: <Widget>[
              FunctionItem(
                  label: '调起百度地图客户端导航',
                  sublabel: 'OpenBaiduMapNaviPage',
                  target: OpenBaiduMapNaviPage()),
              FunctionItem(
                  label: '调起百度地图客户端路线规划',
                  sublabel: 'OpenBaiduMapRoutePage',
                  target: OpenBaiduMapRoutePage()),
              FunctionItem(
                  label: '调起百度地图客户端Poi详情',
                  sublabel: 'OpenBaiduMapPoiDetailPage',
                  target: OpenBaiduMapPoiDetailPage()),
              FunctionItem(
                  label: '调起百度地图客户端Poi周边',
                  sublabel: 'OpenBaiduMapPoiNearPage',
                  target: OpenBaiduMapPoiNearPage()),
              FunctionItem(
                  label: '调起百度地图客户端全景图',
                  sublabel: 'OpenBaiduMapPanoramaPage',
                  target: OpenBaiduMapPanoramaPage()),
              FunctionItem(
                  label: '坐标转换',
                  sublabel: 'CoordTypeConvertPage',
                  target: CoordTypeConvertPage()),
            ],
          ),
        ],
      ),
    );
  }
}
