import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.kotlin_camera/camera');

  String imageBase64="";
Uint8List? imageData;
  Future<void> _takePicture() async {
    try {
     // Call Kotlin method to capture image
      final byteData = await platform.invokeMethod('takePicture');
      
      // Cast the result as Uint8List
      setState(() {
        imageData = byteData;
      });

    } on PlatformException catch (e) {
      print("Failed to take picture: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Camera Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
imageData != null
                ? Image.memory(imageData!) // Display the image
                : const Text("No image captured"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePicture,
              child: const Text("Take Picture"),
            ),
          ],
        ),
      ),
    );
  }
}
