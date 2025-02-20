import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller = window?.rootViewController as! FlutterViewController
        let toastChannel = FlutterMethodChannel(name: ToastHandler.CHANNEL, binaryMessenger: controller.binaryMessenger)
            ToastHandler.register(with: toastChannel, in: controller.view)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
}
