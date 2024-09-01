#include "windows_screenshot_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <atlimage.h>

namespace windows_screenshot
{

  // static
  void WindowsScreenshotPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "windows_screenshot",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<WindowsScreenshotPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  WindowsScreenshotPlugin::WindowsScreenshotPlugin() {}

  WindowsScreenshotPlugin::~WindowsScreenshotPlugin() {}

  void WindowsScreenshotPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("getPlatformVersion") == 0)
    {
      std::ostringstream version_stream;
      version_stream << "Windows ";
      if (IsWindows10OrGreater())
      {
        version_stream << "10+";
      }
      else if (IsWindows8OrGreater())
      {
        version_stream << "8";
      }
      else if (IsWindows7OrGreater())
      {
        version_stream << "7";
      }
      result->Success(flutter::EncodableValue(version_stream.str()));
    }
    else if (method_call.method_name().compare("screenshot") == 0)
    {
      int x1, y1, x2, y2, w, h;

      // get screen dimensions
      x1 = GetSystemMetrics(SM_XVIRTUALSCREEN);
      y1 = GetSystemMetrics(SM_YVIRTUALSCREEN);
      x2 = GetSystemMetrics(SM_CXVIRTUALSCREEN);
      y2 = GetSystemMetrics(SM_CYVIRTUALSCREEN);
      w = x2 - x1;
      h = y2 - y1;

      // copy screen to bitmap
      HDC hScreen = GetDC(NULL);
      HDC hDC = CreateCompatibleDC(hScreen);
      HBITMAP hBitmap = CreateCompatibleBitmap(hScreen, w, h);
      HGDIOBJ old_obj = SelectObject(hDC, hBitmap);
      BitBlt(hDC, 0, 0, w, h, hScreen, x1, y1, SRCCOPY);

      // save bitmap to clipboard
      OpenClipboard(NULL);
      EmptyClipboard();
      SetClipboardData(CF_BITMAP, hBitmap);
      CloseClipboard();

      // std::vector<BYTE> pngBuf = Hbitmap2PNG(hBitmap);
      // result->Success(flutter::EncodableValue(pngBuf));
      // clean up
      SelectObject(hDC, old_obj);
      DeleteDC(hDC);
      ReleaseDC(NULL, hScreen);
      DeleteObject(hBitmap);
      result->Success(flutter::EncodableValue("DONE"));
    }
    else
    {
      result->NotImplemented();
    }
  }
  // std::vector<BYTE> Hbitmap2PNG(HBITMAP hbitmap)
  // {
  //   std::vector<BYTE> buf;
  //   if (hbitmap != NULL)
  //   {
  //     IStream *stream = NULL;
  //     CreateStreamOnHGlobal(0, TRUE, &stream);
  //     CImage image;
  //     ULARGE_INTEGER liSize;

  //     // screenshot to png and save to stream
  //     image.Attach(hbitmap);
  //     image.Save(stream, Gdiplus::ImageFormatPNG);
  //     IStream_Size(stream, &liSize);
  //     DWORD len = liSize.LowPart;
  //     IStream_Reset(stream);
  //     buf.resize(len);
  //     IStream_Read(stream, &buf[0], len);
  //     stream->Release();
  //   }
  //   return buf;
  // }
} // namespace windows_screenshot
