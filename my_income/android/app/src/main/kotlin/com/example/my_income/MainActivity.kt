package com.mm_tv.pro
import android.content.pm.PackageManager
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.mm_tv.pro/check"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "checkPackages") {
                val packageNames = call.argument<List<String>>("packageNames")
                if (packageNames != null) {
                    val isInstalled = checkAnyPackage(packageNames)
                    result.success(isInstalled)
                } else {
                    result.error("INVALID_ARGUMENT", "Package names are required", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun checkAnyPackage(packageNames: List<String>): Boolean {
        for (packageName in packageNames) {
            if (checkPackage(packageName)) {
                return true
            }
        }
        return false
    }

    private fun checkPackage(packageName: String): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES)
            true
        } catch (e: PackageManager.NameNotFoundException) {
            false
        }
    }
}
