package com.baidu.mapapi.search.bean.option.poi;

import com.baidu.mapapi.search.poi.PoiFilter;

/**
 * POI检索过滤条件
 */
public class PoiSearchFilter {
    /**
     * POI所属行业类型，设置该字段可提高检索速度和过滤经度
     */
    PoiFilter.IndustryType industryType;

    PoiSortBasicType sortBasic;

    /**
     * 排序规则
     */
    int sortRule;

    /**
     * 是否有团购
     */
    boolean isGroupon;

    /**
     * 是否有打折
     */
    boolean isDiscount;

    public PoiFilter toPoiFilter() {
        PoiFilter poiFilter = new PoiFilter.Builder()
                .industryType(industryType)
                .sortRule(sortRule)
                .isGroupon(isDiscount)
                .sortName(getSortName())
                .isDiscount(isGroupon).build();
        return poiFilter;
    }

    private PoiFilter.SortName getSortName() {
        PoiFilter.SortName sortName = PoiFilter.SortName.HotelSortName.DEFAULT;
        switch (sortBasic) {
            case HOTEL_DEFAULT:
                sortName = PoiFilter.SortName.HotelSortName.DEFAULT;
                break;
            case HOTEL_PRICE:
                sortName = PoiFilter.SortName.HotelSortName.HOTEL_PRICE;
                break;
            case HOTEL_DISTANCE:
                sortName = PoiFilter.SortName.HotelSortName.HOTEL_DISTANCE;
                break;
            case HOTEL_TOTAL_SCORE:
                sortName = PoiFilter.SortName.HotelSortName.HOTEL_TOTAL_SCORE;
                break;
            case HOTEL_LEVEL:
                sortName = PoiFilter.SortName.HotelSortName.HOTEL_LEVEL;
                break;
            case HOTEL_HEALTH_SCORE:
                sortName = PoiFilter.SortName.HotelSortName.HOTEL_HEALTH_SCORE;
                break;
            case CATER_DEFAULT:
                sortName = PoiFilter.SortName.CaterSortName.DEFAULT;
                break;
            case CATER_PRICE:
                sortName = PoiFilter.SortName.CaterSortName.CATER_PRICE;
                break;
            case CATER_DISTANCE:
                sortName = PoiFilter.SortName.CaterSortName.CATER_DISTANCE;
                break;
            case CATER_TASTE_RATING:
                sortName = PoiFilter.SortName.CaterSortName.CATER_TASTE_RATING;
                break;
            case CATER_OVERALL_RATING:
                sortName = PoiFilter.SortName.CaterSortName.CATER_OVERALL_RATING;
                break;
            case CATER_SERVICE_RATING:
                sortName = PoiFilter.SortName.CaterSortName.CATER_SERVICE_RATING;
                break;
            case LIFE_DEFAULT:
                sortName = PoiFilter.SortName.LifeSortName.DEFAULT;
                break;
            case LIFE_PRICE:
                sortName = PoiFilter.SortName.LifeSortName.PRICE;
                break;
            case LIFE_DISTANCE:
                sortName = PoiFilter.SortName.LifeSortName.DISTANCE;
                break;
            case LIFE_OVERALL_RATING:
                sortName = PoiFilter.SortName.LifeSortName.LIFE_OVERALL_RATING;
                break;
            case LIFE_COMMENT_NUMBER:
                sortName = PoiFilter.SortName.LifeSortName.LIFE_COMMENT_RATING;
                break;
            default:
                break;
        }

        return sortName;
    }

}
