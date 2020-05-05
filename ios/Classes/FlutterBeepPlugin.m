#import "FlutterBeepPlugin.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation FlutterBeepPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_beep"
            binaryMessenger:[registrar messenger]];
  FlutterBeepPlugin* instance = [[FlutterBeepPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"playSysSound" isEqualToString:call.method]) {
    NSNumber *soundId = (NSNumber *)call.arguments[@"soundId"];
    AudioServicesPlaySystemSound([soundId integerValue]);
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
