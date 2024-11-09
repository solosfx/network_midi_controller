import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_midi_controller/network_midi_controller_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelNetworkMidiController platform =
      MethodChannelNetworkMidiController();
  const MethodChannel channel = MethodChannel('network_midi_controller');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatform(), 'iOS');
  });
}
