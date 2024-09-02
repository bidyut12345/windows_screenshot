import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:screen_capturer/screen_capturer.dart';

import 'windows_screenshot_platform_interface.dart';

class WindowsScreenshot {
  Future<String?> getPlatformVersion() {
    return WindowsScreenshotPlatform.instance.getPlatformVersion();
  }

  Future<String?> screenShot() {
    return WindowsScreenshotPlatform.instance.screenShot();
  }

  Future<Uint8List?> getscreenShot() async {
    if (!kIsWeb && Platform.isWindows) {
      await screenShot();
    } else {
      if (!await screenCapturer.isAccessAllowed()) await screenCapturer.requestAccess();
      await screenCapturer.capture(mode: CaptureMode.screen);
    }
    await Future.delayed(const Duration(milliseconds: 10));
    return await screenCapturer.readImageFromClipboard();
  }
}
