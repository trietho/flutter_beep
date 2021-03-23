import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Beep Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextButton(
                child: Text("Beep Success"),
                onPressed: () => FlutterBeep.beep(),
              ),
              TextButton(
                child: Text("Beep Fail"),
                onPressed: () => FlutterBeep.beep(false),
              ),
              TextButton(
                child: Text("Beep Android Custom"),
                onPressed: () => FlutterBeep.playSysSound(
                    AndroidSoundIDs.TONE_CDMA_ABBR_ALERT),
              ),
              TextButton(
                child: Text("Beep something"),
                onPressed: () => FlutterBeep.playSysSound(41),
              ),
              TextButton(
                child: Text("Beep iOS Custom"),
                onPressed: () =>
                    FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
