#ifndef FLUTTER_PLUGIN_WINDOWS_SCREENSHOT_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOWS_SCREENSHOT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace windows_screenshot {

class WindowsScreenshotPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WindowsScreenshotPlugin();

  virtual ~WindowsScreenshotPlugin();

  // Disallow copy and assign.
  WindowsScreenshotPlugin(const WindowsScreenshotPlugin&) = delete;
  WindowsScreenshotPlugin& operator=(const WindowsScreenshotPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace windows_screenshot

#endif  // FLUTTER_PLUGIN_WINDOWS_SCREENSHOT_PLUGIN_H_
