package com.gonoter.flutter_beep;

import android.media.AudioManager;
import android.media.ToneGenerator;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterBeepPlugin */
public class FlutterBeepPlugin implements FlutterPlugin, MethodCallHandler {
  private ToneGenerator toneGen = new ToneGenerator(AudioManager.STREAM_SYSTEM, 100);

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_beep");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("playSysSound")) {
      int soundId = call.argument("soundId");
      playSysSound(soundId);
      result.success(true);
    } else if (call.method.equals("stopSysSound")) {
      stopSysSound();
      result.success(true);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  private void playSysSound(int soundID) {
    toneGen.startTone(soundID);
  }

  private void stopSysSound() {
    toneGen.stopTone();
  }
}
