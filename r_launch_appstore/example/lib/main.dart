import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:r_launch_appstore/r_launch_appstore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _rLaunchAppstorePlugin = RLaunchAppstore();

  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    if (Platform.isIOS) {
      _rLaunchAppstorePlugin.launchIOSStore('414478124');
    } else {
      _rLaunchAppstorePlugin.launchAndroidStore('com.whatsapp.w4b');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: OutlinedButton(
              onPressed: initPlatformState, child: const Text('Open AppStore')),
        ),
      ),
    );
  }
}
