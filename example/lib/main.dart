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
  String yymm = "";

  @override
  void initState() {
    super.initState();
    Timer.run(() async {
      while (true) {
        try {
          var tm = DateTime.now().millisecondsSinceEpoch;
          var data = (await _windowsScreenshotPlugin.getscreenShot())!;
          image = MemoryImage(data);
          yymm = "${DateTime.now().millisecondsSinceEpoch - tm} : ${data.length / 1024}";
          print(yymm);
          setState(() {});
        } catch (e) {
          print(e);
        }
        await Future.delayed(Duration(milliseconds: 10));
      }
    });
  }

  ImageProvider? image;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Plugin example app'),
        // ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.centerRight,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  if (image != null)
                    Image(
                      image: image!,
                      gaplessPlayback: true,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                yymm,
                style: TextStyle(color: Colors.black, backgroundColor: Colors.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
