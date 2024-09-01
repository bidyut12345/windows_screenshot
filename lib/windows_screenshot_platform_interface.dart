import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'windows_screenshot_method_channel.dart';

abstract class WindowsScreenshotPlatform extends PlatformInterface {
  /// Constructs a WindowsScreenshotPlatform.
  WindowsScreenshotPlatform() : super(token: _token);

  static final Object _token = Object();

  static WindowsScreenshotPlatform _instance = MethodChannelWindowsScreenshot();

  /// The default instance of [WindowsScreenshotPlatform] to use.
  ///
  /// Defaults to [MethodChannelWindowsScreenshot].
  static WindowsScreenshotPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WindowsScreenshotPlatform] when
  /// they register themselves.
  static set instance(WindowsScreenshotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> screenShot() {
    throw UnimplementedError('screenShot() has not been implemented.');
  }
}
