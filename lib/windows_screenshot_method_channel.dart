import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'windows_screenshot_platform_interface.dart';

/// An implementation of [WindowsScreenshotPlatform] that uses method channels.
class MethodChannelWindowsScreenshot extends WindowsScreenshotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('windows_screenshot');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> screenShot() async {
    final version = await methodChannel.invokeMethod<String>('screenshot');
    return version;
  }
}
