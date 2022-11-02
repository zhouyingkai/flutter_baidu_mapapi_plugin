package com.baidu.mapapi.search.bean.result.sugesstion;

import com.baidu.mapapi.model.LatLng;
import com.baidu.mapapi.search.core.PoiChildrenInfo;
import com.baidu.mapapi.search.sug.SuggestionResult;

import java.util.ArrayList;
import java.util.List;

public class SugesstionInfoBean {
    /** 联想词联想词名称 */
    public String key;

    /** 联想结果经纬度坐标 */
    public LatLng location;

    /** 联想结果唯一标示，ID */
    public String uid;

    /** 联想结果所在城市 */
    public String city;

    /** 联想结果所在区县 */
    public String district;

    /** 联想结果分类，默认不召回，需要权限。*/
    public String tag;

    /** 联想结果地址，默认不召回，需要权限。*/
    public String address;

    /// 联想结果子节点，默认不召回，需要权限。
    public List<PoiChildrenInfoBean> children = new ArrayList<>();

    public SugesstionInfoBean(SuggestionResult.SuggestionInfo suggestionInfo){
        if(null == suggestionInfo){
            return;
        }

        this.address = suggestionInfo.address;
        this.city = suggestionInfo.city;
        this.district = suggestionInfo.district;
        this.key = suggestionInfo.key;
        this.tag = suggestionInfo.tag;
        this.uid = suggestionInfo.uid;
        this.location = suggestionInfo.pt;

        List<PoiChildrenInfo> poiChildrenInfoList = suggestionInfo.getPoiChildrenInfoList();
        if (null == poiChildrenInfoList || poiChildrenInfoList.size() <= 0) {
            return;
        }

        for (PoiChildrenInfo poiChildrenInfo: poiChildrenInfoList){
            PoiChildrenInfoBean poiChildrenInfoBean = new PoiChildrenInfoBean(poiChildrenInfo);
            children.add(poiChildrenInfoBean);
        }
    }
}
