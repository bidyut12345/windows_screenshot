import 'package:flutter_test/flutter_test.dart';
import 'package:windows_screenshot/windows_screenshot.dart';
import 'package:windows_screenshot/windows_screenshot_platform_interface.dart';
import 'package:windows_screenshot/windows_screenshot_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWindowsScreenshotPlatform
    with MockPlatformInterfaceMixin
    implements WindowsScreenshotPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WindowsScreenshotPlatform initialPlatform = WindowsScreenshotPlatform.instance;

  test('$MethodChannelWindowsScreenshot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWindowsScreenshot>());
  });

  test('getPlatformVersion', () async {
    WindowsScreenshot windowsScreenshotPlugin = WindowsScreenshot();
    MockWindowsScreenshotPlatform fakePlatform = MockWindowsScreenshotPlatform();
    WindowsScreenshotPlatform.instance = fakePlatform;

    expect(await windowsScreenshotPlugin.getPlatformVersion(), '42');
  });
}
