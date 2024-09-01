import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:windows_screenshot/windows_screenshot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _windowsScreenshotPlugin = WindowsScreenshot();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 200), (timer) async {
      try {
        image = MemoryImage((await _windowsScreenshotPlugin.getscreenShot())!);
      } catch (e) {
        print(e);
      }
      setState(() {});
    });
  }

  ImageProvider? image;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (image != null) Image(image: image!),
            ],
          ),
        ),
      ),
    );
  }
}
