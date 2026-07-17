package com.bcflutter.week13.ejercicio_03_platform_channel_bateria

import android.content.Context
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// ============================================
// Lado nativo (Android/Kotlin) del platform channel de batería.
// Este archivo ya está completo — el trabajo de este ejercicio está en
// starter/lib/main.dart (lado Dart). No necesitas escribir Kotlin, pero
// lee el código: es exactamente el patrón de la teoría 04.
// ============================================
class MainActivity : FlutterActivity() {
    private val channelName = "com.bcflutter.week13/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
