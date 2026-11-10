import Flutter
import UIKit

/// タブバーの配置に必要な画面形状 (縦型バーの端・隠れる領域) を Flutter へ渡す。
///
/// 対応するチャンネル名は Dart 側の `screenLayoutChannelName`。
enum ScreenLayoutChannel {
    private static let name = "jp.ac.fun.dotto/screen_layout"

    static func register(messenger: FlutterBinaryMessenger) {
        let channel = FlutterMethodChannel(name: name, binaryMessenger: messenger)
        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "getScreenLayout":
                result(screenLayout())
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    private static func screenLayout() -> [String: Any] {
        guard let view = flutterView() else {
            return ["verticalBarEdge": NSNull(), "occlusions": [], "isPartialWindow": false]
        }
        let isPartialWindow = isPartialWindow(of: view)
        guard #available(iOS 27.1, *) else {
            return ["verticalBarEdge": NSNull(), "occlusions": [], "isPartialWindow": isPartialWindow]
        }
        let edge: Any = switch view.traitCollection.verticalBarEdge {
        case .leading: "leading"
        case .trailing: "trailing"
        default: NSNull()
        }
        let occlusions = view.reservedRegions(kind: .occlusion)
            .filter { $0.isActive }
            .map { region in
                [
                    "x": region.frame.origin.x,
                    "y": region.frame.origin.y,
                    "width": region.frame.size.width,
                    "height": region.frame.size.height,
                ]
            }
        return ["verticalBarEdge": edge, "occlusions": occlusions, "isPartialWindow": isPartialWindow]
    }

    // 分割表示などで、ウィンドウが画面全体より小さいかを判定する。
    private static func isPartialWindow(of view: UIView) -> Bool {
        guard let screen = view.window?.windowScene?.screen else { return false }
        let window = view.window?.bounds.size ?? screen.bounds.size
        let full = screen.bounds.size
        return window.width < full.width - 1 || window.height < full.height - 1
    }

    private static func flutterView() -> UIView? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController?.view
    }
}
