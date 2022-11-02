#import "FlutterBmfsearchPlugin.h"
#import "BMFSearchManager.h"

@implementation FlutterBmfsearchPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    
    [BMFSearchManager registerWithRegistrar:registrar];
}


@end
