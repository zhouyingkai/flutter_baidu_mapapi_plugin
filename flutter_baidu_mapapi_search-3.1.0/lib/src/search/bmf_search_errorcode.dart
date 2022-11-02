/// 检索结果状态码
enum BMFSearchErrorCode {
  ///<检索结果正常返回
  NO_ERROR,

  ///<检索词有岐义
  AMBIGUOUS_KEYWORD,

  ///<检索地址有岐义
  AMBIGUOUS_ROURE_ADDR,

  ///<该城市不支持公交搜索
  NOT_SUPPORT_BUS,

  ///<不支持跨城市公交
  NOT_SUPPORT_BUS_2CITY,

  ///<没有找到检索结果
  RESULT_NOT_FOUND,

  ///<起终点太近
  ST_EN_TOO_NEAR,

  ///<key错误
  KEY_ERROR,

  ///<网络连接错误
  NETWOKR_ERROR,

  ///<网络连接超时
  NETWOKR_TIMEOUT,

  ///<还未完成鉴权，请在鉴权通过后重试
  PERMISSION_UNFINISHED,

  ///<室内图ID错误
  INDOOR_ID_ERROR,

  ///<室内图检索楼层错误
  FLOOR_ERROR,

  ///<起终点不在支持室内路线的室内图内
  INDOOR_ROUTE_NO_IN_BUILDING,

  ///<起终点不在同一个室内
  INDOOR_ROUTE_NO_IN_SAME_BUILDING,

  ///<参数错误
  PARAMETER_ERROR,

  ///<服务器错误
  SERVER_ERROR,

  ///<需开通权限功能，用户在API控制台中创建或设置某APP的时候禁用了某项服务，若需开通权限，可进入API控制台为AK勾选对应服务
  SERVER_NO_PERMISSIONS,

  ///<用户需开通高级权限功能
  SERVER_NO_ADVANCED_PERMISSIONS,

  ///<所在地区无数据覆盖
  SERVER_DISTRICT_NO_DATA,

  ///<天气服务查询的区域编码与约定的编码不符
  SERVER_DISTRICT_ID_ERROR,

  ///<poi室内检索服务错误 Android独有
  POIINDOOR_SERVER_ERROR,

  ///<跨城公共交通服务器内部错误 Android独有
  MASS_TRANSIT_SERVER_ERROR,

  ///<跨城公共交通错误码：参数无效 Android独有
  MASS_TRANSIT_OPTION_ERROR,

  ///<跨城公共交通没有匹配的POI Android独有
  MASS_TRANSIT_NO_POI_ERROR,

  ///<请求错误 Android独有
  REQUEST_ERROR,
}
