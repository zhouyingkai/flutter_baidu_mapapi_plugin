#import "FlutterBmflocationPlugin.h"
#import "BMFLocationManager.h"

@implementation FlutterBmflocationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    [BMFLocationManager registerWithRegistrar:registrar];
}

@end
