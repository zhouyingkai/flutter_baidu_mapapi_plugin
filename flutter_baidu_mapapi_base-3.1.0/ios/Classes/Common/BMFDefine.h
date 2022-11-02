//
//  BMFDefine.h
//  flutter_baidu_mapapi_base
//
//  Created by Zhang,Baojin on 2021/2/5.
//

#ifndef BMFDefine_h
#define BMFDefine_h

// 如果release状态就不执行NSLog函数
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

#endif /* BMFDefine_h */
