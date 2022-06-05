import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'r_launch_appstore_method_channel.dart';

abstract class RLaunchAppstorePlatform extends PlatformInterface {
  /// Constructs a RLaunchAppstorePlatform.
  RLaunchAppstorePlatform() : super(token: _token);

  static final Object _token = Object();

  static RLaunchAppstorePlatform _instance = MethodChannelRLaunchAppstore();

  /// The default instance of [RLaunchAppstorePlatform] to use.
  ///
  /// Defaults to [MethodChannelRLaunchAppstore].
  static RLaunchAppstorePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RLaunchAppstorePlatform] when
  /// they register themselves.
  static set instance(RLaunchAppstorePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> launchAndroidStore(String packageName,
      [String storePkg = "com.android.vending"]) {
    throw UnimplementedError('launchAndroidStore() has not been implemented.');
  }

  Future<bool?> launchIOSStore(String appId) {
    throw UnimplementedError('launchIOSStore() has not been implemented.');
  }
}
