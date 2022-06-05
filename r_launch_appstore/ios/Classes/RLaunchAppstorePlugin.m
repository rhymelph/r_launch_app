#import "RLaunchAppstorePlugin.h"
#if __has_include(<r_launch_appstore/r_launch_appstore-Swift.h>)
#import <r_launch_appstore/r_launch_appstore-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "r_launch_appstore-Swift.h"
#endif

@implementation RLaunchAppstorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRLaunchAppstorePlugin registerWithRegistrar:registrar];
}
@end
