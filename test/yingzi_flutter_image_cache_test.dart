import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yingzi_flutter_image_cache/yingzi_flutter_image_cache.dart';

void main() {
  const MethodChannel channel = MethodChannel('yingzi_flutter_image_cache');

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
  
  });
}
