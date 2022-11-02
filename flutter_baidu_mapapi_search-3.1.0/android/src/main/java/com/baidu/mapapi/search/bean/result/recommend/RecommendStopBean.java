package com.baidu.mapapi.search.bean.result.recommend;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.core.RecommendStopInfo;
import com.baidu.mapapi.search.recommendstop.RecommendStopResult;

import java.util.ArrayList;
import java.util.List;

public class RecommendStopBean extends ResultBean {

    /**
     * 推荐上车点信息
     */
    List<RecommendStopInfoBean> recommendStopInfoList = new ArrayList<>();

    public RecommendStopBean(RecommendStopResult recommendStopResult) {

        if (recommendStopResult == null) {
            return;
        }
        this.error = recommendStopResult.error;

        List<RecommendStopInfo> infoList = recommendStopResult.getRecommendStopInfoList();
        if (infoList == null || infoList.size() <= 0) {
            return;
        }

        for (RecommendStopInfo recommendStopInfo : infoList) {
            RecommendStopInfoBean recommendStopInfoBean = new RecommendStopInfoBean(recommendStopInfo);
            recommendStopInfoList.add(recommendStopInfoBean);
        }
    }

}
