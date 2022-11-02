import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/function_group.widget.dart';
import 'package:flutter_baidu_mapapi_search_example/CustomWidgets/function_item.widget.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/buildingsearch/bmf_buildingpsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/buslineSearch/bmf_buslinesearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/disrictSearch/bmf_districtsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/geoCodeSearch/bmf_geocodesearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/geoCodeSearch/bmf_regeocodesearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/poiSearch/bmf_poiboundsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/poiSearch/bmf_poicitysearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/poiSearch/bmf_poidetailsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/poiSearch/bmf_poiindoorsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/poiSearch/bmf_poinearsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/recommendStopSearch/bmf_recommendstopsearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/routes/bmf_driving_routeplan_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/routes/bmf_masstransit_routeplan_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/routes/bmf_riding_routeplan_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/routes/bmf_transit_routeplan_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/routes/bmf_walk_routeplan_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/shareSearch/bmf_sharesearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/sugSearch/bmf_suggestioncodesearch_page.dart';
import 'package:flutter_baidu_mapapi_search_example/DemoPages/weatherSearch/bmf_weathersearch_page.dart';

class BMFMapSearchDemo extends StatelessWidget {
  const BMFMapSearchDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          FunctionGroup(
            headLabel: '公交检索',
            children: <Widget>[
              FunctionItem(
                  label: '公交检索',
                  sublabel: 'BMFBuslineSearchPage',
                  target: BMFBuslineSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '行政区域检索',
            children: <Widget>[
              FunctionItem(
                  label: '行政区域检索',
                  sublabel: ' BMFDistrictSearchPage',
                  target: BMFDistrictSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '地理编码/逆地理编码检索',
            children: <Widget>[
              FunctionItem(
                  label: '正地理编码',
                  sublabel: 'BMFGeoCodeSearchPage',
                  target: BMFGeoCodeSearchPage()),
              FunctionItem(
                  label: '逆地理编码',
                  sublabel: 'BMFReGeoCodeSearchPage',
                  target: BMFReGeoCodeSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: 'poi检索',
            children: <Widget>[
              FunctionItem(
                  label: 'poi城市检索',
                  sublabel: 'BMFPoiCitySearchPage',
                  target: BMFPoiCitySearchPage()),
              FunctionItem(
                  label: 'poi周边检索',
                  sublabel: 'BMFPoiNearBySearchPage',
                  target: BMFPoiNearBySearchPage()),
              FunctionItem(
                  label: 'poi矩形检索',
                  sublabel: 'BMFPoiBoundSearchPage',
                  target: BMFPoiBoundSearchPage()),
              FunctionItem(
                  label: 'poi详情检索',
                  sublabel: 'BMFPoiDetailSearchPage',
                  target: BMFPoiDetailSearchPage()),
              FunctionItem(
                  label: 'poi室内检索',
                  sublabel: 'BMFPoiIndoorSearchPage',
                  target: BMFPoiIndoorSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '路线规划',
            children: <Widget>[
              FunctionItem(
                  label: '驾车路线规划',
                  sublabel: 'BMFDrvingRoutePlanPage',
                  target: BMFDrivingRoutePlanPage()),
              FunctionItem(
                  label: '步行路线规划',
                  sublabel: 'BMFWalkingRoutePlanPage',
                  target: BMFWalkingRoutePlanPage()),
              FunctionItem(
                  label: '骑行路线规划',
                  sublabel: 'BMFRidingRoutePlanPage',
                  target: BMFRidingRoutePlanPage()),
              FunctionItem(
                  label: '市内公交路线规划',
                  sublabel: 'BMFTransitRoutePlanPage',
                  target: BMFTransitRoutePlanPage()),
              FunctionItem(
                  label: '跨城公交路线规划',
                  sublabel: 'BMFMassTransitRoutePlanPage',
                  target: BMFMassTransitRoutePlanPage()),
            ],
          ),
          FunctionGroup(
            headLabel: 'share短串分享检索',
            children: <Widget>[
              FunctionItem(
                  label: '短串分享',
                  sublabel: 'BMFShareSearchPage',
                  target: BMFShareSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: 'sug检索',
            children: <Widget>[
              FunctionItem(
                  label: 'sug检索',
                  sublabel: 'BMFSugSearchPage',
                  target: BMFSugSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '推荐上车点检索',
            children: <Widget>[
              FunctionItem(
                  label: '推荐上车点检索',
                  sublabel: 'BMFRecommendStopSearchPage',
                  target: BMFRecommendStopSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '天气检索',
            children: <Widget>[
              FunctionItem(
                  label: '天气检索',
                  sublabel: 'BMFWeatherSearchPage',
                  target: BMFWeatherSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '地图建筑物检索',
            children: <Widget>[
              FunctionItem(
                  label: '地图建筑物检索',
                  sublabel: 'BMFBuildingSearchPage',
                  target: BMFBuildingSearchPage()),
            ],
          )
        ],
      ),
    );
  }
}
