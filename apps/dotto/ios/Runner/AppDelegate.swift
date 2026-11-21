import UIKit
import Flutter
import FirebaseAppCheck

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureAppCheckProviderFactory()
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
        ScreenLayoutChannel.register(
            messenger: engineBridge.applicationRegistrar.messenger()
        )
    }

    /// App Check の Provider Factory を、プラグイン登録より前に設定する。
    ///
    /// GoogleService-Info.plist を同梱しているため、firebase_core プラグインの登録時に
    /// ネイティブで `FirebaseApp.configure()` が呼ばれる。firebase_app_check プラグインは
    /// それより後に登録されるため、プラグインの Factory が間に合わず SDK 既定の
    /// DeviceCheck が使われ、Dart 側の `activate(providerApple:)` も無視されてしまう。
    /// (https://github.com/firebase/flutterfire/issues/18613)
    private func configureAppCheckProviderFactory() {
        #if DEBUG
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        #else
        AppCheck.setAppCheckProviderFactory(AppAttestProviderFactory())
        #endif
    }
}
