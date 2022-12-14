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
            headLabel: '????????????',
            children: <Widget>[
              FunctionItem(
                  label: '????????????',
                  sublabel: 'BMFBuslineSearchPage',
                  target: BMFBuslineSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '??????????????????',
            children: <Widget>[
              FunctionItem(
                  label: '??????????????????',
                  sublabel: ' BMFDistrictSearchPage',
                  target: BMFDistrictSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '????????????/?????????????????????',
            children: <Widget>[
              FunctionItem(
                  label: '???????????????',
                  sublabel: 'BMFGeoCodeSearchPage',
                  target: BMFGeoCodeSearchPage()),
              FunctionItem(
                  label: '???????????????',
                  sublabel: 'BMFReGeoCodeSearchPage',
                  target: BMFReGeoCodeSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: 'poi??????',
            children: <Widget>[
              FunctionItem(
                  label: 'poi????????????',
                  sublabel: 'BMFPoiCitySearchPage',
                  target: BMFPoiCitySearchPage()),
              FunctionItem(
                  label: 'poi????????????',
                  sublabel: 'BMFPoiNearBySearchPage',
                  target: BMFPoiNearBySearchPage()),
              FunctionItem(
                  label: 'poi????????????',
                  sublabel: 'BMFPoiBoundSearchPage',
                  target: BMFPoiBoundSearchPage()),
              FunctionItem(
                  label: 'poi????????????',
                  sublabel: 'BMFPoiDetailSearchPage',
                  target: BMFPoiDetailSearchPage()),
              FunctionItem(
                  label: 'poi????????????',
                  sublabel: 'BMFPoiIndoorSearchPage',
                  target: BMFPoiIndoorSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '????????????',
            children: <Widget>[
              FunctionItem(
                  label: '??????????????????',
                  sublabel: 'BMFDrvingRoutePlanPage',
                  target: BMFDrivingRoutePlanPage()),
              FunctionItem(
                  label: '??????????????????',
                  sublabel: 'BMFWalkingRoutePlanPage',
                  target: BMFWalkingRoutePlanPage()),
              FunctionItem(
                  label: '??????????????????',
                  sublabel: 'BMFRidingRoutePlanPage',
                  target: BMFRidingRoutePlanPage()),
              FunctionItem(
                  label: '????????????????????????',
                  sublabel: 'BMFTransitRoutePlanPage',
                  target: BMFTransitRoutePlanPage()),
              FunctionItem(
                  label: '????????????????????????',
                  sublabel: 'BMFMassTransitRoutePlanPage',
                  target: BMFMassTransitRoutePlanPage()),
            ],
          ),
          FunctionGroup(
            headLabel: 'share??????????????????',
            children: <Widget>[
              FunctionItem(
                  label: '????????????',
                  sublabel: 'BMFShareSearchPage',
                  target: BMFShareSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: 'sug??????',
            children: <Widget>[
              FunctionItem(
                  label: 'sug??????',
                  sublabel: 'BMFSugSearchPage',
                  target: BMFSugSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '?????????????????????',
            children: <Widget>[
              FunctionItem(
                  label: '?????????????????????',
                  sublabel: 'BMFRecommendStopSearchPage',
                  target: BMFRecommendStopSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '????????????',
            children: <Widget>[
              FunctionItem(
                  label: '????????????',
                  sublabel: 'BMFWeatherSearchPage',
                  target: BMFWeatherSearchPage()),
            ],
          ),
          FunctionGroup(
            headLabel: '?????????????????????',
            children: <Widget>[
              FunctionItem(
                  label: '?????????????????????',
                  sublabel: 'BMFBuildingSearchPage',
                  target: BMFBuildingSearchPage()),
            ],
          )
        ],
      ),
    );
  }
}
