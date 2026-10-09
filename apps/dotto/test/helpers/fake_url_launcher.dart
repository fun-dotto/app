import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

/// 開いた URL を記録するプラットフォームの URL 起動処理のフェイク。
final class FakeUrlLauncher extends UrlLauncherPlatform
    with MockPlatformInterfaceMixin {
  new({this.canOpen = true});

  /// URL を開けるかどうか。
  final bool canOpen;

  /// 開いた URL。
  final openedUrls = <String>[];

  @override
  LinkDelegate? get linkDelegate => null;

  @override
  Future<bool> canLaunch(String url) async => canOpen;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    if (canOpen) openedUrls.add(url);
    return canOpen;
  }

  /// [UrlLauncherPlatform.instance] をこのフェイクに差し替え、テスト後に戻す。
  void install(void Function(void Function()) addTearDown) {
    final original = UrlLauncherPlatform.instance;
    UrlLauncherPlatform.instance = this;
    addTearDown(() => UrlLauncherPlatform.instance = original);
  }
}
