import 'network_midi_controller_platform_interface.dart';

class NetworkMidiController {
  Future<String?> getPlatform() {
    return NetworkMidiControllerPlatform.instance.getPlatform();
  }

  Future<void> initialize() {
    return NetworkMidiControllerPlatform.instance.initialize();
  }

  Future<void> enableService() {
    return NetworkMidiControllerPlatform.instance.enableService();
  }

  Future<void> disableService() {
    return NetworkMidiControllerPlatform.instance.disableService();
  }

  /// Sends a MIDI command.
  Future<void> sendMIDICommand({
    required int channelCommand,
    required int midiNote,
    required int velocity,
  }) {
    return NetworkMidiControllerPlatform.instance.sendMIDICommand(
      channelCommand: channelCommand,
      midiNote: midiNote,
      velocity: velocity,
    );
  }
}
