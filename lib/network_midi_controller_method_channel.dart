import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'network_midi_controller_platform_interface.dart';

/// An implementation of [NetworkMidiControllerPlatform] that uses method channels.
class MethodChannelNetworkMidiController extends NetworkMidiControllerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('network_midi_controller');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
