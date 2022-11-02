package com.baidu.mapapi.search.bean.result.sugesstion;

import com.baidu.mapapi.search.bean.result.ResultBean;
import com.baidu.mapapi.search.core.PoiChildrenInfo;
import com.baidu.mapapi.search.sug.SuggestionResult;

import java.util.ArrayList;
import java.util.List;

/**
 * 建议检索结果bean
 */
public class SuggestionResultBean extends ResultBean {
    /** Sug检索结果列表 */
    List<SugesstionInfoBean> suggestionList = new ArrayList<>();

    public SuggestionResultBean(SuggestionResult suggestionResult){
        if (null == suggestionResult) {
            return;
        }

        this.error = suggestionResult.error;

        List<SuggestionResult.SuggestionInfo> suggestionInfoList = suggestionResult.getAllSuggestions();
        if (null == suggestionInfoList || suggestionInfoList.size() <= 0) {
            return;
        }

        for (SuggestionResult.SuggestionInfo suggestionInfo: suggestionInfoList){
            SugesstionInfoBean sugesstionInfoBean = new SugesstionInfoBean(suggestionInfo);
            suggestionList.add(sugesstionInfoBean);
        }
    }
}
