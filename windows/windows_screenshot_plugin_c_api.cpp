#include "include/windows_screenshot/windows_screenshot_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "windows_screenshot_plugin.h"

void WindowsScreenshotPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  windows_screenshot::WindowsScreenshotPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
