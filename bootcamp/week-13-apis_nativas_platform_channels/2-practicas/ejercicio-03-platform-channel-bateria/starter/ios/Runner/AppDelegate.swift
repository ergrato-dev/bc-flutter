import Flutter
import UIKit

// ============================================
// Lado nativo (iOS/Swift) del platform channel de batería — referencia
// fiel al patrón, NO verificado en este bootcamp (requiere host macOS con
// Xcode, ver docs/docker-setup.md). Solo el lado Android se compila y
// verifica en este ejercicio.
// ============================================
@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private let channelName = "com.bcflutter.week13/battery"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let channel = FlutterMethodChannel(
      name: channelName,
      binaryMessenger: engineBridge.engine.binaryMessenger
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == "getBatteryLevel" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.receiveBatteryLevel(result: result)
    }
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == .unknown {
      result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available.", details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }
}
