
import 'network_midi_controller_platform_interface.dart';

class NetworkMidiController {
  Future<String?> getPlatformVersion() {
    return NetworkMidiControllerPlatform.instance.getPlatformVersion();
  }
}
