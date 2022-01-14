package com.honjow.open_by_default

import androidx.annotation.NonNull
import android.content.Context;
import android.content.Intent;

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** OpenByDefaultPlugin */
class OpenByDefaultPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var channel : MethodChannel
  private lateinit var applicationContext : Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "honjow.com/open_by_default/methods")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "openByDefault") {
      val openByDefaultIntent = Intent()
      openByDefaultIntent.setAction(android.provider.Settings.ACTION_APP_OPEN_BY_DEFAULT_SETTINGS)
      openByDefaultIntent.addCategory(Intent.CATEGORY_DEFAULT)
      openByDefaultIntent.setData(android.net.Uri.parse("package:${applicationContext.packageName}"))
      openByDefaultIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      openByDefaultIntent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
      openByDefaultIntent.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
      applicationContext.startActivity(openByDefaultIntent)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
