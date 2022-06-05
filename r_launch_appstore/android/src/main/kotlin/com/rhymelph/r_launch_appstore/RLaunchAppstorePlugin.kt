package com.rhymelph.r_launch_appstore

import android.app.Activity
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** RLaunchAppstorePlugin */
class RLaunchAppstorePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "r_launch_appstore")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "launchAndroidStore" -> {
                val packageName = call.argument<String>("packageName")
                val storePkg = call.argument<String>("storePkg")
                if (packageName == null) {
                    result.success(false)
                    return
                }
                val intent = Intent(Intent.ACTION_VIEW)
                intent.data = Uri.parse("market://detail?id=$packageName")
                intent.`package` = storePkg
                if (intent.resolveActivity(activity.packageManager) != null) {
                    activity.startActivity(intent)
                    result.success(true)
                    return
                } else {
                    val intent2 = Intent(Intent.ACTION_VIEW)
                    intent2.data =
                        Uri.parse("https://play.google.com/store/apps/details?id=$packageName");
                    if (intent2.resolveActivity(activity.packageManager) != null) {
                        activity.startActivity(intent2)
                        result.success(true)
                        return
                    }
                }
                result.success(false)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivity() {
    }
}
