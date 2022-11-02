/*
 * Copyright (C) 2020 Baidu, Inc. All Rights Reserved.
 */
package com.baidu.mapapi.search.bean.result.poi;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.baidu.mapapi.search.bean.option.LatLngBean;
import com.baidu.mapapi.search.core.PoiChildrenInfo;
import com.baidu.mapapi.search.core.PoiDetailInfo;
import com.baidu.mapapi.search.poi.PoiDetailResult;

public class PoiDetailDetailResultBean {
    /** 距离中心点的距离，圆形区域检索时返回 */
    public  int distance;

    /** POI类型："hotel","cater","life"等 */
    public String type;

    /** POI标签 */
    public String tag;

    /** POI对应的导航引导点坐标。大型面状POI的导航引导点，一般为各类出入口，方便结合导航、路线规划等服务使用 */
    public LatLngBean naviLocation;

    /** POI详情页URL */
    public String detailURL;

    /** POI商户的价格 */
    public double price;

    /** POI营业时间 */
    public String openingHours;

    /** POI总体评分 */
    public  double overallRating;

    /** POI口味评分 */
    public double tasteRating;

    /** POI服务评分 */
    public double serviceRating;

    /** POI环境评分 */
    public double environmentRating;

    /** POI星级（设备）评分 */
    public double facilityRating;

    /** POI卫生评分 */
    public double hygieneRating;

    /** POI技术评分 */
    public double technologyRating;

    /** POI图片数目 */
    public int imageNumber;

    /** POI团购数目 */
    public int grouponNumber;

    /** POI优惠数目 */
    public int discountNumber;

    /** POI评论数目 */
    public int commentNumber;

    /** POI收藏数目 */
    public  int favoriteNumber;

    /** POI签到数目 */
    public int checkInNumber;

    /**
     * POI是否有详情信息
     */
    boolean hasDetailInfo;

    /** POI详情子节点信息，默认不返回，需要权限。*/
    List<PoiDetailChildrenInfoReaultBean> children = new ArrayList<>();

    public PoiDetailDetailResultBean(PoiDetailInfo poiDetailInfo) {
        if (null == poiDetailInfo) {
            return;
        }

        this.checkInNumber = poiDetailInfo.getCheckinNum();
        this.commentNumber = poiDetailInfo.getCommentNum();
        this.detailURL = poiDetailInfo.getDetailUrl();
        this.discountNumber = poiDetailInfo.getDiscountNum();
        this.distance = poiDetailInfo.getDistance();
        this.environmentRating = poiDetailInfo.getEnvironmentRating();
        this.facilityRating = poiDetailInfo.getFacilityRating();
        this.favoriteNumber = poiDetailInfo.getFavoriteNum();
        this.grouponNumber = poiDetailInfo.getGrouponNum();
        this.hygieneRating = poiDetailInfo.getHygieneRating();
        this.imageNumber = poiDetailInfo.getImageNum();
        this.naviLocation = new LatLngBean(poiDetailInfo.getNaviLocation());
        this.openingHours = poiDetailInfo.getShopHours();
        this.overallRating = poiDetailInfo.getOverallRating();
        this.price = poiDetailInfo.getPrice();
        this.serviceRating = poiDetailInfo.getServiceRating();
        this.tasteRating = poiDetailInfo.getTasteRating();
        this.technologyRating = poiDetailInfo.getTechnologyRating();
        this.type = poiDetailInfo.getType();
        this.tag = poiDetailInfo.getTag();

        List<PoiChildrenInfo>  poiChildrenInfos = poiDetailInfo.getPoiChildrenInfoList();
        if (null == poiChildrenInfos || poiChildrenInfos.size() <= 0) {
            return;
        }

        Iterator itr = poiChildrenInfos.iterator();
        PoiChildrenInfo poiChildrenInfo;
        while (itr.hasNext()) {
            poiChildrenInfo = (PoiChildrenInfo) itr.next();
            if (null == poiChildrenInfo) {
                continue;
            }

            PoiDetailChildrenInfoReaultBean poiDetailChildrenInfoReaultBean =
                    new PoiDetailChildrenInfoReaultBean(poiChildrenInfo);

            children.add(poiDetailChildrenInfoReaultBean);
        }

        if (children.size() > 0) {
            this.hasDetailInfo = true;
        }
    }

    public PoiDetailDetailResultBean(PoiDetailResult poiDetailResult) {
        if (null == poiDetailResult) {
            return;
        }

        this.checkInNumber = poiDetailResult.getCheckinNum();
        this.commentNumber = poiDetailResult.getCommentNum();
        this.detailURL = poiDetailResult.getDetailUrl();
        this.discountNumber = poiDetailResult.getDiscountNum();
        this.environmentRating = poiDetailResult.getEnvironmentRating();
        this.facilityRating = poiDetailResult.getFacilityRating();
        this.favoriteNumber = poiDetailResult.getFavoriteNum();
        this.grouponNumber = poiDetailResult.getGrouponNum();
        this.hygieneRating = poiDetailResult.getHygieneRating();
        this.imageNumber = poiDetailResult.getImageNum();
        this.openingHours = poiDetailResult.getShopHours();
        this.overallRating = poiDetailResult.getOverallRating();
        this.price = poiDetailResult.getPrice();
        this.serviceRating = poiDetailResult.getServiceRating();
        this.tasteRating = poiDetailResult.getTasteRating();
        this.technologyRating = poiDetailResult.getTechnologyRating();
        this.type = poiDetailResult.getType();
        this.tag = poiDetailResult.getTag();
    }
}
