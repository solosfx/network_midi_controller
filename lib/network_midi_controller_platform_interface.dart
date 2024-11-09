import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'network_midi_controller_method_channel.dart';

abstract class NetworkMidiControllerPlatform extends PlatformInterface {
  /// Constructs a NetworkMidiControllerPlatform.
  NetworkMidiControllerPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkMidiControllerPlatform _instance =
      MethodChannelNetworkMidiController();

  /// The default instance of [NetworkMidiControllerPlatform] to use.
  ///
  /// Defaults to [MethodChannelNetworkMidiController].
  static NetworkMidiControllerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NetworkMidiControllerPlatform] when
  /// they register themselves.
  static set instance(NetworkMidiControllerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatform() {
    throw UnimplementedError('getPlatform() has not been implemented.');
  }

  /// Method to initialize the MIDI controller.
  Future<void> initialize() {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  /// Method to enable the MIDI Network Session.
  Future<void> enableService() {
    throw UnimplementedError('enableService() has not been implemented.');
  }

  /// Method to disable the MIDI Network Session.
  Future<void> disableService() {
    throw UnimplementedError('disableService() has not been implemented.');
  }

  /// Method to send a MIDI command.
  Future<void> sendMIDICommand({
    required int channelCommand,
    required int midiNote,
    required int velocity,
  }) {
    throw UnimplementedError('sendMIDICommand() has not been implemented.');
  }
}
