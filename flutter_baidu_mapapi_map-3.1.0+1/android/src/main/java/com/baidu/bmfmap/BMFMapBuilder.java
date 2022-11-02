package com.baidu.bmfmap;

import com.baidu.mapapi.map.BaiduMapOptions;
import com.baidu.mapapi.map.LogoPosition;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.model.LatLngBounds;

import android.content.Context;
import android.graphics.Point;
import android.graphics.Rect;
import io.flutter.plugin.common.BinaryMessenger;

/**
 * Copyright (C) 2019 Baidu, Inc. All Rights Reserved.
 */
public class BMFMapBuilder {

    private int mapType;
    private int minZoomLevel;
    private int maxZoomLevel;
    private LatLng center;
    private Boolean buildingsEnabled;
    private Boolean compassEnabled;
    private Boolean showMapPoi;
    private Boolean trafficEnabled;
    private Boolean baiduHeatMapEnabled;
    private Boolean allGesturesEnabled;
    private Boolean zoomEnabledWithDoubleClick;
    private Boolean zoomEnabledWithTap;
    private Boolean showMapScaleBar;
    private Boolean changeCenterWithDoubleTouchPointEnabled;
    private Boolean baseIndoorMapEnabled;
    private Boolean showIndoorMapPoi;
    private Point compassPosition;
    private Boolean rotateEnabled;
    private Boolean scrollEnabled;
    private Boolean zoomEnabled;
    private Boolean overlookEnabled;
    private Boolean showZoomControl;
    private float zoomLevel;
    private LogoPosition logoPosition;
    private LatLngBounds limitMapBounds;
    private LatLngBounds visibleMapBounds;
    private Point scaleControlPosition;
    private Point mapZoomControlPosition;
    private Rect viewPadding;
    // 3.1.0 新增属性
    private Integer languageType;
    private Integer fontSizeLevel;

    public BMFMapController build(int id, Context context, BinaryMessenger binaryMessenger,
                                  String viewType, BaiduMapOptions options) {

        BMFMapController mapController = new BMFMapController(id, context, binaryMessenger,
                viewType, options);

        mapController.setMapType(mapType);
        mapController.setBaiduHeatMapEnabled(baiduHeatMapEnabled);
        mapController.setBuildingsEnabled(buildingsEnabled);
        mapController.setIndoorEnable(baseIndoorMapEnabled);
        mapController.setMapStatusLimits(limitMapBounds);
        mapController.setMaxAndMinZoomLevel(maxZoomLevel, minZoomLevel);
        mapController.setScaleControlPosition(scaleControlPosition);
        mapController.setZoomControlsPosition(mapZoomControlPosition);
        mapController.setTrafficEnabled(trafficEnabled);
        mapController.showMapPoi(showMapPoi);
        mapController.showMapIndoorPoi(showIndoorMapPoi);
        mapController.showScaleControl(showMapScaleBar);
        mapController.setEnlargeCenterWithDoubleClickEnable(changeCenterWithDoubleTouchPointEnabled);
        mapController.setCompassEnabled(compassEnabled);
        mapController.setAllGesturesEnabled(allGesturesEnabled);
        mapController.setDoubleClickZoomEnabled(zoomEnabledWithDoubleClick);
        mapController.setTwoTouchClickZoomEnabled(zoomEnabledWithTap);
        mapController.setCompassPotion(compassPosition);
        mapController.setRotateGesturesEnabled(rotateEnabled);
        mapController.setScrollGesturesEnabled(scrollEnabled);
        mapController.setZoomGesturesEnabled(zoomEnabled);
        mapController.setOverlookingGesturesEnabled(overlookEnabled);
        mapController.showZoomControl(showZoomControl);
        mapController.setLogoPosition(logoPosition);
        mapController.setVisibleMapBounds(visibleMapBounds);
        mapController.setZoomLevel(zoomLevel);
        mapController.setCenter(center);
        mapController.setMapLanguage(languageType);
        mapController.setFontSizeLevel(fontSizeLevel);
        if (viewPadding != null) {
            mapController.setViewPadding(viewPadding.left, viewPadding.top, viewPadding.right,
                    viewPadding.bottom);
        }
        return mapController;
    }

    public BMFMapBuilder mapType(int mapType) {
        this.mapType = mapType;
        return this;
    }

    public BMFMapBuilder center(LatLng center) {
        this.center = center;
        return this;
    }

    public BMFMapBuilder zoomLevel(float zoomLevel) {
        this.zoomLevel = zoomLevel;
        return this;
    }
    
    public BMFMapBuilder minZoomLevel(int minZoomLevel) {
        this.minZoomLevel = minZoomLevel;
        return this;
    }

    public BMFMapBuilder maxZoomLevel(int maxZoomLevel) {
        this.maxZoomLevel = maxZoomLevel;
        return this;
    }

    public BMFMapBuilder compassEnabled(boolean compassEnabled) {
        this.compassEnabled = compassEnabled;
        return this;
    }

    public BMFMapBuilder buildingsEnabled(boolean buildingsEnabled) {
        this.buildingsEnabled = buildingsEnabled;
        return this;
    }

    public BMFMapBuilder showMapPoi(boolean showMapPoi) {
        this.showMapPoi = showMapPoi;
        return this;
    }

    public BMFMapBuilder trafficEnabled(boolean trafficEnabled) {
        this.trafficEnabled = trafficEnabled;
        return this;
    }

    public BMFMapBuilder baiduHeatMapEnabled(boolean baiduHeatMapEnabled) {
        this.baiduHeatMapEnabled = baiduHeatMapEnabled;
        return this;
    }

    public BMFMapBuilder allGesturesEnabled(boolean allGesturesEnabled) {
        this.allGesturesEnabled = allGesturesEnabled;
        return this;
    }

    public BMFMapBuilder zoomEnabledWithTap(boolean zoomEnabledWithTap) {
        this.zoomEnabledWithTap = zoomEnabledWithTap;
        return this;
    }

    public BMFMapBuilder zoomEnabledWithDoubleClick(boolean zoomEnabledWithDoubleClick) {
        this.zoomEnabledWithDoubleClick = zoomEnabledWithDoubleClick;
        return this;
    }

    public BMFMapBuilder showMapScaleBar(boolean showMapScaleBar) {
        this.showMapScaleBar = showMapScaleBar;
        return this;
    }

    public BMFMapBuilder changeCenterWithDoubleTouchPointEnabled(
            boolean changeCenterWithDoubleTouchPointEnabled) {
        this.changeCenterWithDoubleTouchPointEnabled = changeCenterWithDoubleTouchPointEnabled;
        return this;
    }

    public BMFMapBuilder baseIndoorMapEnabled(boolean baseIndoorMapEnabled) {
        this.baseIndoorMapEnabled = baseIndoorMapEnabled;
        return this;
    }

    public BMFMapBuilder showIndoorMapPoi(boolean showIndoorMapPoi) {
        this.showIndoorMapPoi = showIndoorMapPoi;
        return this;
    }

    public BMFMapBuilder compassPosition(Point compassPosition) {
        this.compassPosition = compassPosition;
        return this;
    }

    public BMFMapBuilder rotateEnabled(boolean rotateEnabled) {
        this.rotateEnabled = rotateEnabled;
        return this;
    }

    public BMFMapBuilder scrollEnabled(boolean scrollEnabled) {
        this.scrollEnabled = scrollEnabled;
        return this;
    }
    
    public BMFMapBuilder zoomEnabled(boolean zoomEnabled) {
        this.zoomEnabled = zoomEnabled;
        return this;
    }

    public BMFMapBuilder overlookEnabled(boolean overlookEnabled) {
        this.overlookEnabled = overlookEnabled;
        return this;
    }

    public BMFMapBuilder showZoomControl(Boolean showZoomControl) {
        this.showZoomControl = showZoomControl;
        return this;
    }

    public BMFMapBuilder logoPosition(LogoPosition logoPosition) {
        this.logoPosition = logoPosition;
        return this;
    }

    public BMFMapBuilder visibleMapBounds(LatLngBounds visibleMapBounds) {
        this.visibleMapBounds = visibleMapBounds;
        return this;
    }

    public BMFMapBuilder scaleControlPosition(Point scaleControlPosition) {
        this.scaleControlPosition = scaleControlPosition;
        return this;
    }

    public BMFMapBuilder mapZoomControlPosition(Point mapZoomControlPosition) {
        this.mapZoomControlPosition = mapZoomControlPosition;
        return this;
    }

    public BMFMapBuilder viewPadding(int left, int top, int right, int bottom) {
        this.viewPadding = new Rect(left, top, right, bottom);
        return this;
    }

    public BMFMapBuilder limitMapBounds(LatLngBounds latLngBounds) {
        this.limitMapBounds = latLngBounds;
        return this;
    }

    public BMFMapBuilder languageType(Integer languageType) {
        this.languageType = languageType;
        return this;
    }

    public BMFMapBuilder fontSizeLevel(Integer fontSizeLevel) {
        this.fontSizeLevel = fontSizeLevel;
        return this;
    }
}
