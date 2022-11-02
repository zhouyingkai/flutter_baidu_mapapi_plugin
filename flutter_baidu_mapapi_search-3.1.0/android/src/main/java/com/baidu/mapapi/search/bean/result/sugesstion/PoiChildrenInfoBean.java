package com.baidu.mapapi.search.bean.result.sugesstion;

import com.baidu.mapapi.search.core.PoiChildrenInfo;

public class PoiChildrenInfoBean {
    /** poi子点uid */
    public String uid;

    /** poi子点名称 */
    public String name;

    /** poi子点简称 */
    public String showName;

    public PoiChildrenInfoBean(PoiChildrenInfo poiChildrenInfo){
        if(null == poiChildrenInfo){
            return;
        }

        this.uid = poiChildrenInfo.getUid();
        this.name = poiChildrenInfo.getName();
        this.showName = poiChildrenInfo.getShowName();
    }
}
