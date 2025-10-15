package com.gonoter.flutter_beep;

import android.media.AudioManager;
import android.media.ToneGenerator;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** FlutterBeepPlugin */
public class FlutterBeepPlugin implements FlutterPlugin, MethodCallHandler {
  private ToneGenerator toneGen;
  private int currentVolume = 100; // Default volume (0-100)

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_beep");
    channel.setMethodCallHandler(this);
    toneGen = new ToneGenerator(AudioManager.STREAM_SYSTEM, currentVolume);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("playSysSound")) {
      int soundId = call.argument("soundId");
      Integer duration = call.argument("duration");
      Integer volume = call.argument("volume");

      if (volume != null && volume != currentVolume) {
        setVolume(volume);
      }

      if (duration != null && duration > 0) {
        playSysSoundWithDuration(soundId, duration);
      } else {
        playSysSound(soundId);
      }
      result.success(true);
    } else if (call.method.equals("stopSysSound")) {
      stopSysSound();
      result.success(true);
    } else if (call.method.equals("setVolume")) {
      int volume = call.argument("volume");
      setVolume(volume);
      result.success(true);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    if (toneGen != null) {
      toneGen.release();
      toneGen = null;
    }
  }

  private void playSysSound(int soundID) {
    if (toneGen != null) {
      toneGen.startTone(soundID);
    }
  }

  private void playSysSoundWithDuration(int soundID, int durationMs) {
    if (toneGen != null) {
      toneGen.startTone(soundID, durationMs);
    }
  }

  private void stopSysSound() {
    if (toneGen != null) {
      toneGen.stopTone();
    }
  }

  private void setVolume(int volume) {
    // Ensure volume is between 0 and 100
    currentVolume = Math.max(0, Math.min(100, volume));

    // Recreate ToneGenerator with new volume
    if (toneGen != null) {
      toneGen.release();
    }
    toneGen = new ToneGenerator(AudioManager.STREAM_SYSTEM, currentVolume);
  }
}
