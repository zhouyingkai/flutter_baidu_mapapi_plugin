package com.baidu.mapapi.search.bean;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.PoiDetailInfo;

import java.util.ArrayList;
import java.util.List;

public class PoiDetailInfoBean {

    // 以下是POI扩展信息，仅当scope=2时，显示该字段，不同的poi类型，显示的detail_info字段不同
    /**
     * 距离中心点的距离，圆形区域检索时返回
     */
    public int distance;

    /**
     * 所属分类，如’hotel’、’cater’
     */
    public String type;

    /**
     * 标签
     */
    public String tag;

    /**
     * POI对应的导航引导点坐标。大型面状POI的导航引导点，一般为各类出入口，方便结合导航、路线规划等服务使用
     */
    public LatLng naviLocation;

    /**
     * poi的详情页Url
     */
    public String detailURL;

    /**
     * poi商户的价格
     */
    public double price;

    /**
     * 营业时间
     */
    public String openingHours;

    /**
     * 总体评分
     */
    public double overallRating;

    /**
     * 口味评分
     */
    public double tasteRating;

    /**
     * 服务评分
     */
    public double serviceRating;

    /**
     * 环境评分
     */
    public double environmentRating;

    /**
     * 星级（设备）评分
     */
    public double facilityRating;

    /**
     * 卫生评分
     */
    public double hygieneRating;

    /**
     * 技术评分
     */
    public double technologyRating;

    /**
     * 图片数
     */
    public int imageNumber;

    /**
     * 团购数
     */
    public int grouponNumber;

    /**
     * 优惠数
     */
    public int discountNumber;

    /**
     * 评论数
     */
    public int commentNumber;

    /**
     * 收藏数
     */
    public int favoriteNumber;

    /**
     * 签到数
     */
    public int checkInNumber;


    /// POI详情子节点信息，默认不返回，需要权限。
    List<DetailChildrenInfoBean> children = new ArrayList<>();

    public PoiDetailInfoBean(PoiDetailInfo poiDetailInfo) {
        this.distance = poiDetailInfo.distance;
        this.type = poiDetailInfo.type;
        this.tag = poiDetailInfo.tag;
        this.naviLocation = poiDetailInfo.naviLocation;
        this.detailURL = poiDetailInfo.detailUrl;
        this.price = poiDetailInfo.price;
        this.openingHours = poiDetailInfo.shopHours;
        this.overallRating = poiDetailInfo.overallRating;
        this.tasteRating = poiDetailInfo.tasteRating;
        this.serviceRating = poiDetailInfo.serviceRating;
        this.environmentRating = poiDetailInfo.environmentRating;
        this.facilityRating = poiDetailInfo.facilityRating;
        this.hygieneRating = poiDetailInfo.hygieneRating;
        this.technologyRating = poiDetailInfo.technologyRating;
        this.imageNumber = poiDetailInfo.imageNum;
        this.grouponNumber = poiDetailInfo.grouponNum;
        this.discountNumber = poiDetailInfo.discountNum;
        this.commentNumber =  poiDetailInfo.commentNum;
        this.favoriteNumber =  poiDetailInfo.favoriteNum;
        this.checkInNumber =  poiDetailInfo.checkinNum;
//        this.children =  poiDetailInfo;
    }

    private class DetailChildrenInfoBean {
        /// poi子点uid
        public String uid;

        /// poi子点名称
        public String name;

        /// poi子点简称
        public String showName;

        /// poi子点类别
        public String tag;

        /// poi子节点经纬度
        public LatLng pt;

        /// poi子点地址
        public String address;
    }
}
