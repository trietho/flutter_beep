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
    NSNumber *withVibration = call.arguments[@"vibrate"];

    // iOS system sounds don't support volume control directly
    // Volume is controlled by system settings
    if (withVibration != nil && [withVibration boolValue]) {
      // Play sound with vibration
      AudioServicesPlayAlertSound([soundId integerValue]);
    } else {
      // Play sound only
      AudioServicesPlaySystemSound([soundId integerValue]);
    }
    result(nil);
  } else if ([@"vibrate" isEqualToString:call.method]) {
    // Vibrate only (iOS doesn't support custom vibration patterns via AudioToolbox)
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    result(nil);
  } else if ([@"setVolume" isEqualToString:call.method]) {
    // iOS doesn't support programmatic volume control for system sounds
    // Volume is controlled by the device's physical volume buttons
    result(@"iOS does not support programmatic volume control for system sounds");
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
