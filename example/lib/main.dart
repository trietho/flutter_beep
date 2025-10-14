import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Beep Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const BeepDemoPage(),
    );
  }
}

class BeepDemoPage extends StatefulWidget {
  const BeepDemoPage({Key? key}) : super(key: key);

  @override
  State<BeepDemoPage> createState() => _BeepDemoPageState();
}

class _BeepDemoPageState extends State<BeepDemoPage> {
  double _volume = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Beep Plugin Demo'),
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Legacy Methods',
            [
              _buildButton("Beep Success", () => FlutterBeep.beep()),
              _buildButton("Beep Fail", () => FlutterBeep.beep(false)),
            ],
          ),
          _buildSection(
            'Common Use Cases',
            [
              _buildButton("Success", () => FlutterBeep.success()),
              _buildButton("Error", () => FlutterBeep.error()),
              _buildButton("Warning", () => FlutterBeep.warning()),
              _buildButton("Notification", () => FlutterBeep.notification()),
              _buildButton("Click", () => FlutterBeep.click()),
              _buildButton("Confirm", () => FlutterBeep.confirm()),
              _buildButton("Cancel", () => FlutterBeep.cancel()),
            ],
          ),
          _buildSection(
            'Action Sounds',
            [
              _buildButton("Camera Shutter", () => FlutterBeep.cameraShutter()),
              _buildButton("Start Recording", () => FlutterBeep.startRecording()),
              _buildButton("Stop Recording", () => FlutterBeep.stopRecording()),
              _buildButton("Screen Locked", () => FlutterBeep.screenLocked()),
              _buildButton("Screen Unlocked", () => FlutterBeep.screenUnlocked()),
            ],
          ),
          _buildSection(
            'Communication Sounds',
            [
              _buildButton("Mail Received", () => FlutterBeep.mailReceived()),
              _buildButton("Voicemail", () => FlutterBeep.voicemail()),
              _buildButton("Calendar Alert", () => FlutterBeep.calendarAlert()),
              _buildButton("Ringtone", () => FlutterBeep.ringtone()),
              _buildButton("Busy Tone", () => FlutterBeep.busy()),
              _buildButton("Call Waiting", () => FlutterBeep.callWaiting()),
            ],
          ),
          _buildSection(
            'Sound Sequences',
            [
              _buildButton("Success Sequence", () => FlutterBeep.successSequence()),
              _buildButton("Error Sequence", () => FlutterBeep.errorSequence()),
              _buildButton("Countdown (3-2-1)", () => FlutterBeep.countdownSequence()),
            ],
          ),
          _buildSection(
            'Volume Control (Android Only)',
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Text('Volume: '),
                    Expanded(
                      child: Slider(
                        value: _volume,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        label: _volume.round().toString(),
                        onChanged: (value) {
                          setState(() => _volume = value);
                          FlutterBeep.setVolume(value.round());
                        },
                      ),
                    ),
                    Text('${_volume.round()}'),
                  ],
                ),
              ),
              _buildButton("Test Volume", () => FlutterBeep.success()),
            ],
          ),
          _buildSection(
            'Advanced Features',
            [
              _buildButton(
                "Play with Duration (Android)",
                () => FlutterBeep.playSysSound(
                  AndroidSoundIDs.TONE_PROP_BEEP,
                  duration: 500,
                ),
              ),
              _buildButton(
                "Play with Vibration (iOS)",
                () => FlutterBeep.playSysSound(
                  AndroidSoundIDs.TONE_PROP_BEEP,
                  vibrate: true,
                ),
              ),
              _buildButton("Vibrate Only", () => FlutterBeep.vibrate()),
            ],
          ),
          _buildSection(
            'Sound Categories',
            [
              _buildButton(
                "Play DTMF Tones",
                () => FlutterBeep.playSequence(BeepCategory.dtmfTones, delayMs: 200),
              ),
              _buildButton(
                "Play Notifications",
                () => FlutterBeep.playSequence(BeepCategory.notifications, delayMs: 300),
              ),
              _buildButton(
                "Play Alerts",
                () => FlutterBeep.playSequence(BeepCategory.alerts, delayMs: 400),
              ),
            ],
          ),
          _buildSection(
            'Custom Sounds',
            [
              _buildButton(
                "Android Custom",
                () => FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT),
              ),
              _buildButton(
                "iOS Custom",
                () => FlutterBeep.playSysSound(iOSSoundIDs.AudioToneBusy),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: children,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
