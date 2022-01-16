package com.honjow.open_by_default

import androidx.annotation.NonNull
import android.content.Context;
import android.content.Intent;
import android.content.pm.verify.domain.DomainVerificationManager
import android.content.pm.verify.domain.DomainVerificationUserState
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.annotation.RequiresApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.lang.Exception

/** OpenByDefaultPlugin */
class OpenByDefaultPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context

    private val manager
        @RequiresApi(Build.VERSION_CODES.S)
        get() = applicationContext.getSystemService(DomainVerificationManager::class.java)

    private val userState
        @RequiresApi(Build.VERSION_CODES.S)
        get() = manager.getDomainVerificationUserState(applicationContext.packageName)

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "honjow.com/open_by_default/methods"
        )
        channel.setMethodCallHandler(this)
    }

    @RequiresApi(Build.VERSION_CODES.S)
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "openByDefault" -> {
                val openByDefaultIntent = Intent(
                    Settings.ACTION_APP_OPEN_BY_DEFAULT_SETTINGS,
                    Uri.parse("package:${applicationContext.packageName}")
                )
                openByDefaultIntent.addCategory(Intent.CATEGORY_DEFAULT)
                    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    .addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
                    .addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
                    .addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)

                val settingsIntent = Intent(
                    Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                    Uri.parse("package:${applicationContext.packageName}")
                )
                settingsIntent.addCategory(Intent.CATEGORY_DEFAULT)
                    .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    .addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
                    .addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)

                try {
                    applicationContext.startActivity(openByDefaultIntent)
                } catch (e: Exception) {
//                    applicationContext.startActivity(settingsIntent)
                }
            }
            "getVerifiedDomains" -> {
                val verifiedDomains = userState?.hostToStateMap
                    ?.filterValues { it == DomainVerificationUserState.DOMAIN_STATE_VERIFIED }
                result.success(verifiedDomains)

            }
            "getSelectedDomains" -> {
                val selectedDomains = userState?.hostToStateMap
                    ?.filterValues { it == DomainVerificationUserState.DOMAIN_STATE_SELECTED }
                result.success(selectedDomains)
            }
            "getUnapprovedDomains" -> {
                val unapprovedDomains = userState?.hostToStateMap
                    ?.filterValues { it == DomainVerificationUserState.DOMAIN_STATE_NONE }
                result.success(unapprovedDomains)
            }
            "getAllDomains" -> {
                val allDomains = userState?.hostToStateMap
                Log.d("debugLog", "allDomains $allDomains")
                result.success(allDomains)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
