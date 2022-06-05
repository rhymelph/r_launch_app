import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:r_launch_appstore/r_launch_appstore_method_channel.dart';

void main() {
  MethodChannelRLaunchAppstore platform = MethodChannelRLaunchAppstore();
  const MethodChannel channel = MethodChannel('r_launch_appstore');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
