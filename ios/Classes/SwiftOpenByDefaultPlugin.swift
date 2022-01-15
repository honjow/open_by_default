import Flutter
import UIKit

public class SwiftOpenByDefaultPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "honjow.com/open_by_default/methods", binaryMessenger: registrar.messenger())
    let instance = SwiftOpenByDefaultPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    return
  }
}
