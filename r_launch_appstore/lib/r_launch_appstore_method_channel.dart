import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'r_launch_appstore_platform_interface.dart';

/// An implementation of [RLaunchAppstorePlatform] that uses method channels.
class MethodChannelRLaunchAppstore extends RLaunchAppstorePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('r_launch_appstore');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> launchIOSStore(String appId) async {
    assert(Platform.isIOS, 'Only use in IOS');
    return await methodChannel.invokeMethod<bool>('launchIOSStore', {
          'appId': appId,
        }) ??
        false;
  }

  @override
  Future<bool> launchAndroidStore(String packageName,
      [String storePkg = "com.android.vending"]) async {
    assert(Platform.isAndroid, 'Only use in android');
    return await methodChannel.invokeMethod<bool>('launchAndroidStore', {
          'packageName': packageName,
          'storePkg': storePkg,
        }) ??
        false;
  }
}
