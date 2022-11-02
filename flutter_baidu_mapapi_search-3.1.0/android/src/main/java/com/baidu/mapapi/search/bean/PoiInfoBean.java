package com.baidu.mapapi.search.bean;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.PoiDetailInfo;
import com.baidu.mapapi.search.core.PoiInfo;

public class PoiInfoBean {
    /**
     * poi名称
     */
    public String name;

    /**
     * poi唯一标识
     * 如果为isPano为true，可用此参数调用街景组件PanoramaService类
     * 的requestPanoramaWithPoiUId方法检索街景数据
     */
    public String uid;

    /**
     * poi地址信息
     */
    public String address;

    /**
     * poi所在省份
     */
    public String province;

    /**
     * poi所在城市
     */
    public String city;

    /**
     * poi所在行政区域
     */
    public String area;

    /**
     * poi对应的街景图id
     */
    public String streetID;

    /**
     * RGC请求结果中，周边POI和请求坐标点的方向关系，比如“内”，“西”，“南”等。
     * 判断时，取结果中的第一个POI的该参数即可，如果返回为“内”则说明经纬度坐标该POI所属的面内
     */
    public String direction;

    /**
     * RGC请求结果中，周边POI和请求坐标点的距离
     * distance = 0，说明经纬度位于POI所在的面内，但是也可能是POI的经纬度点
     */
    public int distance;

    /**
     * poi电话信息
     */
    public String phone;

    /**
     * poi邮编
     */
    public String zipCode;

    /**
     * poi是否有详情页 需要单独处理
     */
    public boolean hasDetailInfo;

    /**
     * poi类型，0：普通点，1：公交站，2：公交线路，3：地铁站，4：地铁线路,
     */
    public int type;

    /**
     * poi坐标, 当ePoiType为2或4时，pt 为空
     */
    public LatLng pt;

    /**
     * poi点是否有美食类详情页面
     */
    public boolean hasCaterDetails;

    /**
     * poi点附近是否有街景，可使用uid检索全景组件的全景数据
     */
    public boolean isPano;

    /**
     * poi分类，如："美食;中餐厅"
     */
    public String tag;

    /**
     * poi扩展信息
     */
    public PoiDetailInfoBean detailInfo;

    /**
     * RGC请求结果中，poi对应的主点poi信息（如，海底捞的主点为上地华联，
     * 该字段则为上地华联的poi信息。如POI无主点，则无该字段为空）
     */
    public PoiInfoBean parentPOI;


    public PoiInfoBean(PoiInfo poiInfo) {
        this.name = poiInfo.name;
        this.uid = poiInfo.uid;
        this.address = poiInfo.address;
        this.province = poiInfo.province;
        this.city = poiInfo.city;
        this.area = poiInfo.area;
        this.streetID = poiInfo.street_id;
        this.phone = poiInfo.phoneNum;
        this.zipCode = poiInfo.postCode;
        this.pt = poiInfo.location;
        this.hasCaterDetails = poiInfo.hasCaterDetails;
        this.isPano = poiInfo.isPano;
        this.tag = poiInfo.tag;
        this.direction = poiInfo.direction;
        this.distance = poiInfo.distance;
        int detail = poiInfo.getDetail();
        if (detail == 0) {
            this.hasDetailInfo = false;
        } else if (detail == 1) {
            this.hasDetailInfo = true;
        }

        if (null != poiInfo.type) {
            this.type = poiInfo.type.ordinal();
        }

        PoiDetailInfo poiDetailInfo = poiInfo.poiDetailInfo;
        if (null != poiDetailInfo) {
            this.detailInfo = new PoiDetailInfoBean(poiDetailInfo);
        }
        PoiInfo.ParentPoiInfo parentPoiInfo = poiInfo.parentPoiInfo;
        if (null == parentPoiInfo) {
            return;
        }

        this.parentPOI = new PoiInfoBean(parentPoiInfo, this);
    }

    private PoiInfoBean(PoiInfo.ParentPoiInfo parentInfo, PoiInfoBean poiInfoBean) {
        this.name = parentInfo.parentPoiName;
        this.tag = parentInfo.parentPoiTag;
        this.address = parentInfo.parentPoiAddress;
        this.pt = parentInfo.parentPoiLocation;
        this.direction = parentInfo.parentPoiDirection;
        this.distance = parentInfo.parentPoiDistance;
        this.uid = parentInfo.parentPoiUid;
        this.province = poiInfoBean.province;
        this.city = poiInfoBean.city;
        this.area = poiInfoBean.area;
        this.streetID = poiInfoBean.streetID;
        this.phone = poiInfoBean.phone;
        this.zipCode = poiInfoBean.zipCode;
        this.hasCaterDetails = poiInfoBean.hasCaterDetails;
        this.isPano = poiInfoBean.isPano;
        this.hasDetailInfo = poiInfoBean.hasDetailInfo;
        this.parentPOI = null;
    }
}
