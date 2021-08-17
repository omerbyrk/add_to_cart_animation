#import "AddToCartAnimationPlugin.h"
#if __has_include(<add_to_cart_animation/add_to_cart_animation-Swift.h>)
#import <add_to_cart_animation/add_to_cart_animation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "add_to_cart_animation-Swift.h"
#endif

@implementation AddToCartAnimationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAddToCartAnimationPlugin registerWithRegistrar:registrar];
}
@end
