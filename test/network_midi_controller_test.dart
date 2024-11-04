import 'package:flutter_test/flutter_test.dart';
import 'package:network_midi_controller/network_midi_controller.dart';
import 'package:network_midi_controller/network_midi_controller_platform_interface.dart';
import 'package:network_midi_controller/network_midi_controller_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNetworkMidiControllerPlatform
    with MockPlatformInterfaceMixin
    implements NetworkMidiControllerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NetworkMidiControllerPlatform initialPlatform = NetworkMidiControllerPlatform.instance;

  test('$MethodChannelNetworkMidiController is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNetworkMidiController>());
  });

  test('getPlatformVersion', () async {
    NetworkMidiController networkMidiControllerPlugin = NetworkMidiController();
    MockNetworkMidiControllerPlatform fakePlatform = MockNetworkMidiControllerPlatform();
    NetworkMidiControllerPlatform.instance = fakePlatform;

    expect(await networkMidiControllerPlugin.getPlatformVersion(), '42');
  });
}
