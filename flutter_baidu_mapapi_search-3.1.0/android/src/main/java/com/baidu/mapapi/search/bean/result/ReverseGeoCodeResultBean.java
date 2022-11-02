package com.baidu.mapapi.search.bean.result;

import com.baidu.mapapi.search.bean.AddressComponentBean;
import com.baidu.mapapi.search.bean.PoiInfoBean;
import com.baidu.mapapi.search.bean.PoiRegionsInfoBean;
import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.PoiInfo;
import com.baidu.mapapi.search.geocode.ReverseGeoCodeResult;

import java.util.ArrayList;
import java.util.List;

public class ReverseGeoCodeResultBean {
    /**
     * 商圈名称
     * 如 "人民大学,中关村,苏州街"，一个坐标检索最多返回3个
     */
    public String businessCircle;

    /**
     * 地址名称
     */
    public String address;

    /**
     * 层次化地址信息
     */
    public AddressComponentBean addressDetail;

    /**
     * 地址坐标
     */
    public LatLng location;

    /**
     * 百度定义的城市id
     */
    public int cityCode;

    /**
     * 地址周边Poi信息，只有在type为MK_REVERSEGEOCODE时才有效
     */
    public List<PoiInfoBean> poiList = new ArrayList<>();

    /**
     * 当前位置结合POI的语义化结果描述
     */
    public String sematicDescription;

    /**
     * 请求中的坐标与POI对应的区域面（AOI）的归属关系信息
     * 以数组形式返回
     */
    public List<PoiRegionsInfoBean> poiRegions =  new ArrayList<>();

    /**
     * 行政区域编码 当{@link ReverseGeoCodeResult.AddressComponent}不为null时有效
     */
    public int acode;

    public ReverseGeoCodeResultBean(ReverseGeoCodeResult reverseGeoCodeResult) {
        this.businessCircle = reverseGeoCodeResult.getBusinessCircle();
        this.address = reverseGeoCodeResult.getAddress();
        this.location = reverseGeoCodeResult.getLocation();
        this.cityCode = reverseGeoCodeResult.getCityCode();
        this.sematicDescription = reverseGeoCodeResult.getSematicDescription();
        this.acode = reverseGeoCodeResult.getAdcode();

        ReverseGeoCodeResult.AddressComponent tmpAddressDetail = reverseGeoCodeResult.getAddressDetail();
        if (null != tmpAddressDetail) {
            this.addressDetail = new AddressComponentBean(tmpAddressDetail);
        }
        List<PoiInfo> poiList = reverseGeoCodeResult.getPoiList();
        if (null != poiList) {
            for (PoiInfo poiInfo: poiList) {
                if (null != poiInfo) {
                    PoiInfoBean poiInfoBean = new PoiInfoBean(poiInfo);
                    this.poiList.add(poiInfoBean);
                }
            }
        }
        List<ReverseGeoCodeResult.PoiRegionsInfo> poiRegionsInfoList = reverseGeoCodeResult.getPoiRegionsInfoList();
        if (null == poiRegionsInfoList) {
            return;
        }
        for (ReverseGeoCodeResult.PoiRegionsInfo poiRegionsInfo:poiRegionsInfoList) {
            PoiRegionsInfoBean poiRegionsInfoBean = new PoiRegionsInfoBean(poiRegionsInfo);
            if (null == poiRegionsInfo) {
                return;
            }
            this.poiRegions.add(poiRegionsInfoBean);
        }
    }
}
