import 'dart:async';

import 'package:flutter/services.dart';

class ExamplePlugin {
  static const MethodChannel _channel = const MethodChannel('example_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get randomString async {
    return await _channel.invokeMethod('randomString');
  }

/// 
/// 两种写法，见下面的写法
  static void callTimer2(Future<dynamic> callback(MethodCall call)) async {
    _channel.setMethodCallHandler(callback);
  }

  static void callTimer(Callback callback) async {
    _channel.setMethodCallHandler(callback);
  }
}

///
/// 定义回调函数
typedef Future<dynamic> Callback(MethodCall call);
