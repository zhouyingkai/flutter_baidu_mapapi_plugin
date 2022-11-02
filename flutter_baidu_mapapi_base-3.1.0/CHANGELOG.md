# 2.0.0

新增功能：
1、新增检索组件；
2、Circle、Polygon 增加镂空效果；
3、Circle、Polygon、Arcline、Dot、Ground、Text 支持属性更新。
问题修复：
1、规范了包名；
2、Marker、Polyline 事件回调返回完整了 Marker 和 Polyline 对象；
3、iOS 端兼容 swift、swift 与 Object-C 混编；
4、解决了部分 Android 机型上卫星图、路况图、百度城市热力图、自定义在线瓦片图不显示的问题；
5、Android 花屏问题解决；
6、全新 Demo。

## 3.0.0

1、适配 null-safe

## 3.1.0

地图Flutter插件3.1更新日志 


新增： 

1、新增大地曲线绘制，polyline新增跨经度180属性； 

2、新增渐变线绘制； 

3、新增3D棱柱绘制； 

4、新增海量点绘制； 

5、新增3D模型绘制； 

6、新增动态轨迹绘制； 

7、overlay新增获取外接矩形bounds接口； 

8、marker新增customMap字段，iconData构造方法； 

9、map新增showmarkers接口（仅支持iOS端）； 

9、map新增language，fontsizelevel属性，驾车检索step节点下新增roadname字段 

10、map新增坐标换接口(地理坐标 <=> 屏幕坐标)； 


修复： 

Android端修复多地图页面切换删除overlay失效问题。 

Android端修复自定义定位图层样式设置方向不旋转问题。 

Android端修复LatLngBounds返回地理坐标问题。 
 

优化： 

升级引擎，提高引擎稳定性 


变更： 

1、增加隐私政策接口，BMFMapSDK.setAgreePrivacy(bool); 

2、BMFMarker()构造废弃，变更为BMFMarker.icon()和BMFMarker.iconData()构造 

3、新增删除traceOverlay接口，MapController.removeTraceOverlay(traceOverlay_id)； 
