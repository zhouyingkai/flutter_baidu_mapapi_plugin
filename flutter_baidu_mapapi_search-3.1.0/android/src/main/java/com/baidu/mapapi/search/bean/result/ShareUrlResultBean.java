package com.baidu.mapapi.search.bean.result;

import com.baidu.mapapi.search.share.ShareUrlResult;

/**
 * poi详情短串分享结果bean
 */
public class ShareUrlResultBean extends ResultBean{
    /** 返回结果url */
    String url;

    public ShareUrlResultBean(ShareUrlResult shareUrlResult){
        if(null == shareUrlResult){
            return;
        }

        this.url = shareUrlResult.getUrl();
        this.error = shareUrlResult.error;
    }
}
