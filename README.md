# flutter_beep
A very lite module to play system sounds and beep for flutter apps (no sound files)
**Sponsor by**
[Go Noter app](https://gonoter.com "Go Noter - Group travel asssistant") - Group travel and expenses assistant!


```dart
import 'package:flutter_beep/flutter_beep.dart';

RaisedButton( child: Text("Beep Success"), onPressed: ()=> FlutterBeep.beep()),
RaisedButton( child: Text("Beep Fail"), onPressed: ()=> FlutterBeep.beep(false)),
RaisedButton( child: Text("Beep Android Custom"), onPressed: ()=> FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT)),
RaisedButton( child: Text("Beep somthing"), onPressed: ()=> FlutterBeep.playSysSound(41)),
RaisedButton( child: Text("Beep iOS Custom"), onPressed: ()=> FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy)),
```


LICENSE: FREE