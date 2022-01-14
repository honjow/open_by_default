import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_by_default/open_by_default.dart';

void main() {
  const channelName = 'honjow.com/open_by_default/methods';
  const MethodChannel channel = MethodChannel(channelName);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('openByDefault', () async {
    await OpenByDefault.open();
  });
}
