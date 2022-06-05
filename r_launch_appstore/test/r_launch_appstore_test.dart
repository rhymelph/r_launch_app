import 'package:flutter_test/flutter_test.dart';
import 'package:r_launch_appstore/r_launch_appstore.dart';
import 'package:r_launch_appstore/r_launch_appstore_platform_interface.dart';
import 'package:r_launch_appstore/r_launch_appstore_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRLaunchAppstorePlatform
    with MockPlatformInterfaceMixin
    implements RLaunchAppstorePlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<bool?> launchAndroidStore(String packageName,
          [String storePkg = "com.android.vending"]) =>
      Future.value(true);

  @override
  Future<bool?> launchIOSStore(String appId) => Future.value(true);
}

void main() {
  final RLaunchAppstorePlatform initialPlatform =
      RLaunchAppstorePlatform.instance;

  test('$MethodChannelRLaunchAppstore is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRLaunchAppstore>());
  });

  test('getPlatformVersion', () async {
    RLaunchAppstore rLaunchAppstorePlugin = RLaunchAppstore();
    MockRLaunchAppstorePlatform fakePlatform = MockRLaunchAppstorePlatform();
    RLaunchAppstorePlatform.instance = fakePlatform;
  });
}
