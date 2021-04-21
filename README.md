# flutter_beep
A very lite module to play system sounds and beep for flutter apps (no sound files)

```dart
import 'package:flutter_beep/flutter_beep.dart';

ElevatedButton(
  child: Text("Beep Success"),
  onPressed: () => FlutterBeep.beep(),
),
ElevatedButton(
  child: Text("Beep Fail"),
  onPressed: () => FlutterBeep.beep(false),
),
ElevatedButton(
  child: Text("Beep Android Custom"),
  onPressed: () =>
      FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT),
),
ElevatedButton(
    child: Text("Beep somthing"),
    onPressed: () => FlutterBeep.playSysSound(41),
),
ElevatedButton(
  child: Text("Beep iOS Custom"),
  onPressed: () => FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy),
),
```
