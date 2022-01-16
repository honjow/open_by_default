import 'dart:async';

import 'package:flutter/services.dart';

import '../open_by_default.dart';

const channelName = 'honjow.com/open_by_default/methods';

class OpenByDefault {
  static const MethodChannel _channel = MethodChannel(channelName);

  static Future<void> open() async {
    await _channel.invokeMethod('openByDefault');
  }

  static Future<Map<String, DomainVerificationUserState>?>
      getAllDomains() async {
    final rult = await _channel.invokeMethod('getAllDomains');
    return _getDomainMap(rult);
  }

  static Future<Map<String, DomainVerificationUserState>?>
      getVerifiedDomains() async {
    final rult = await _channel.invokeMethod('getVerifiedDomains');
    return _getDomainMap(rult);
  }

  static Future<Map<String, DomainVerificationUserState>?>
      getSelectedDomains() async {
    final rult = await _channel.invokeMethod('getSelectedDomains');
    return _getDomainMap(rult);
  }

  static Future<Map<String, DomainVerificationUserState>?>
      getUnapprovedDomains() async {
    final rult = await _channel.invokeMethod('getUnapprovedDomains');
    return _getDomainMap(rult);
  }

  static Map<String, DomainVerificationUserState>? _getDomainMap(
      dynamic srcMap) {
    return (srcMap as Map).map((key, value) =>
        MapEntry(key as String, (value as int).verificationState));
  }
}
