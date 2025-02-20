import 'dart:developer';

import 'package:flutter/services.dart';

class ToastUtil {
  static const MethodChannel _channel = MethodChannel('com.example/toast');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      log("Error al mostrar toast: $e");
    }
  }
}