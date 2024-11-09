import 'package:flutter_test/flutter_test.dart';
import 'package:network_midi_controller/network_midi_controller.dart';
import 'package:network_midi_controller/network_midi_controller_platform_interface.dart';
import 'package:network_midi_controller/network_midi_controller_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNetworkMidiControllerPlatform
    with MockPlatformInterfaceMixin
    implements NetworkMidiControllerPlatform {
  @override
  Future<String?> getPlatform() => Future.value('iOS');

  @override
  Future<void> initialize() {
    throw UnimplementedError();
  }

  @override
  Future<void> sendMIDICommand({
    required int channelCommand,
    required int midiNote,
    required int velocity,
  }) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> disableService() {
    throw UnimplementedError();
  }
  
  @override
  Future<void> enableService() {
    throw UnimplementedError();
  }
}

void main() {
  final NetworkMidiControllerPlatform initialPlatform =
      NetworkMidiControllerPlatform.instance;

  test('$MethodChannelNetworkMidiController is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNetworkMidiController>());
  });

  test('getPlatformVersion', () async {
    NetworkMidiController networkMidiControllerPlugin = NetworkMidiController();
    MockNetworkMidiControllerPlatform fakePlatform =
        MockNetworkMidiControllerPlatform();
    NetworkMidiControllerPlatform.instance = fakePlatform;

    expect(await networkMidiControllerPlugin.getPlatform(), 'iOS');
  });
}
