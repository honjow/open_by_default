#import "OpenByDefaultPlugin.h"
#if __has_include(<open_by_default/open_by_default-Swift.h>)
#import <open_by_default/open_by_default-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "open_by_default-Swift.h"
#endif

@implementation OpenByDefaultPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpenByDefaultPlugin registerWithRegistrar:registrar];
}
@end
