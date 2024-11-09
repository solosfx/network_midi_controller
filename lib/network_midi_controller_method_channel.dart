import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'network_midi_controller_platform_interface.dart';

/// An implementation of [NetworkMidiControllerPlatform] that uses method channels.
class MethodChannelNetworkMidiController extends NetworkMidiControllerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('network_midi_controller');

  @override
  Future<String?> getPlatform() async {
    final version = await methodChannel.invokeMethod<String>('getPlatform');
    return version;
  }

  /// Initialize the MIDI Controller.
  @override
  Future<void> initialize() async {
    try {
      await methodChannel.invokeMethod('initialize');
    } on PlatformException catch (e) {
      print("Failed to initialize MIDI Controller service: ${e.message}");
    }
  }

  /// Enable MIDI Network Session
  @override
  Future<void> enableService() async {
    try {
      await methodChannel.invokeMethod('enableService');
    } on PlatformException catch (e) {
      print("Failed to enable MIDI Network Session: ${e.message}");
    }
  }

  /// Disable MIDI Network Session
  @override
  Future<void> disableService() async {
    try {
      await methodChannel.invokeMethod('disableService');
    } on PlatformException catch (e) {
      print("Failed to disable MIDI Network Session: ${e.message}");
    }
  }

  /// Send a MIDI command with the specified details
  @override
  Future<void> sendMIDICommand({
    required int channelCommand,
    required int midiNote,
    required int velocity,
  }) async {
    try {
      await methodChannel.invokeMethod('sendMIDICommand', {
        'command': channelCommand,
        'note': midiNote,
        'velocity': velocity,
      });
    } on PlatformException catch (e) {
      print("Failed to send MIDI command: ${e.message}");
    }
  }
}
