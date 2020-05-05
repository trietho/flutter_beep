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
          child: Column(children: <Widget>[
            RaisedButton( child: Text("Beep Success"), onPressed: ()=> FlutterBeep.beep()),
            RaisedButton( child: Text("Beep Fail"), onPressed: ()=> FlutterBeep.beep(false)),
            RaisedButton( child: Text("Beep Android Custom"), onPressed: ()=> FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT)),
            RaisedButton( child: Text("Beep somthing"), onPressed: ()=> FlutterBeep.playSysSound(41)),
            RaisedButton( child: Text("Beep iOS Custom"), onPressed: ()=> FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy)),

          ],),
        ),
      ),
    );
  }
}
