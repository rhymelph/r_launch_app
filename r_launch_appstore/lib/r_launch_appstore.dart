import 'r_launch_appstore_platform_interface.dart';

class RLaunchAppstore {
  Future<bool?> launchAndroidStore(String packageName,
      [String storePkg = "com.android.vending"]) async {
    return RLaunchAppstorePlatform.instance
        .launchAndroidStore(packageName, storePkg);
  }

  Future<bool?> launchIOSStore(String appId) async {
    return RLaunchAppstorePlatform.instance.launchIOSStore(appId);
  }
}
