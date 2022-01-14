import 'dart:async';

import 'package:flutter/services.dart';

const channelName = 'honjow.com/open_by_default/methods';

class OpenByDefault {
  static const MethodChannel _channel = MethodChannel(channelName);

  static Future<void> open() async {
    await _channel.invokeMethod('openByDefault');
  }
}
