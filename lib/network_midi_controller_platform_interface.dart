import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'network_midi_controller_method_channel.dart';

abstract class NetworkMidiControllerPlatform extends PlatformInterface {
  /// Constructs a NetworkMidiControllerPlatform.
  NetworkMidiControllerPlatform() : super(token: _token);

  static final Object _token = Object();

  static NetworkMidiControllerPlatform _instance = MethodChannelNetworkMidiController();

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
