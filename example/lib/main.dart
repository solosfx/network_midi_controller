import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:network_midi_controller/network_midi_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platform = 'Test';
  final _networkMidiControllerPlugin = NetworkMidiController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platform;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platform = await _networkMidiControllerPlugin.getPlatform() ??
          'Unknown platform';

      _networkMidiControllerPlugin.initialize();
    } on PlatformException {
      platform = 'Failed to get platform.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platform = platform;
    });
  }

  /// Convert note name and octave to MIDI note number
  int _noteToMidiNumber(String note, int octave) {
    const noteOffsets = {
      'C': 0,
      'C#': 1,
      'D': 2,
      'D#': 3,
      'E': 4,
      'F': 5,
      'F#': 6,
      'G': 7,
      'G#': 8,
      'A': 9,
      'A#': 10,
      'B': 11,
    };
    int noteNumber = (octave + 1) * 12 + noteOffsets[note]!;
    return noteNumber.clamp(0, 127);
  }

  Future<void> sendMIDICommand({
    required String commandType, // "noteOn" or "noteOff"
    required String note,
    required int octave,
    required int channel,
    required int velocity,
  }) async {
    int midiNote = _noteToMidiNumber(note, octave);
    int command = (commandType == 'noteOn') ? 0x90 : 0x80;
    int channelCommand = command + (channel - 1).clamp(0, 15);

    await _networkMidiControllerPlugin.sendMIDICommand(
      channelCommand: channelCommand,
      midiNote: midiNote,
      velocity: velocity.clamp(0, 127),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on $_platform'),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {
                  await sendMIDICommand(
                    commandType: 'noteOn',
                    note: 'C',
                    octave: 4,
                    channel: 1,
                    velocity: 120,
                  );
                },
                child: const Text('Send Note ON'),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {
                  await sendMIDICommand(
                    commandType: 'noteOff',
                    note: 'C',
                    octave: 4,
                    channel: 1,
                    velocity: 0,
                  );
                },
                child: const Text('Send Note OFF'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
