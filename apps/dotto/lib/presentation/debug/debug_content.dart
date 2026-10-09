import 'package:dotto/domain/entity/debug_tokens.dart';
import 'package:dotto/domain/entity/flag.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:material_ui/material_ui.dart';

/// フィーチャーフラグと、その上書き値・実際に使われる値の組。
typedef DebugFlagStatus = ({
  Flag<Object> flag,
  Object? override,
  Object effectiveValue,
});

/// 開発者向けの情報の表示。
final class DebugContent extends StatelessWidget {
  const new({
    required this.tokens,
    required this.flavor,
    required this.flags,
    required this.onTokenTap,
    required this.onFlagTap,
    super.key,
  });

  final DebugTokens tokens;
  final String? flavor;
  final List<DebugFlagStatus> flags;
  final ValueChanged<String> onTokenTap;

  /// 上書きできる bool のフラグがタップされたときに呼ばれる。
  final ValueChanged<Flag<bool>> onFlagTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        children: [
          DottoListSection(
            header: const Text('Token'),
            footer: const Text('タップするとクリップボードにコピーします。'),
            children: [
              _TokenTile(
                label: 'App Check Access Token',
                token: tokens.appCheckToken,
                onTap: onTokenTap,
              ),
              _TokenTile(
                label: 'User ID Token',
                token: tokens.idToken,
                onTap: onTokenTap,
              ),
              _TokenTile(
                label: 'FCM Token',
                token: tokens.fcmToken,
                onTap: onTokenTap,
              ),
            ],
          ),
          DottoListSection(
            header: const Text('Environment'),
            children: [
              DottoListTile(
                firstLine: const Text('Flavor'),
                secondLine: Text(flavor ?? 'Default'),
              ),
            ],
          ),
          DottoListSection(
            header: const Text('Feature Flag'),
            children: [
              for (final status in flags)
                _FlagTile(status: status, onTap: onFlagTap),
            ],
          ),
        ],
      ),
    );
  }
}

final class _TokenTile extends StatelessWidget {
  const new({required this.label, required this.token, required this.onTap});

  final String label;
  final String? token;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final token = this.token;
    return DottoListTile(
      firstLine: Text(label),
      secondLine: Text(
        token ?? '-',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: token == null ? null : () => onTap(token),
    );
  }
}

final class _FlagTile extends StatelessWidget {
  const new({required this.status, required this.onTap});

  final DebugFlagStatus status;
  final ValueChanged<Flag<bool>> onTap;

  @override
  Widget build(BuildContext context) {
    final flag = status.flag;
    return DottoListTile(
      firstLine: Text('${flag.description} Flag'),
      secondLine: Text(switch (status.override) {
        null => 'Use Remote Config',
        final override => 'Forced: $override',
      }),
      thirdLine: Text('Effective: ${status.effectiveValue}'),
      // 上書きできるのは bool のフラグのみ
      trailing: switch (flag) {
        Flag<bool>() => const DottoListTileTrailing.chevron(),
        _ => const DottoListTileTrailing.none(),
      },
      onTap: switch (flag) {
        final Flag<bool> boolFlag => () => onTap(boolFlag),
        _ => null,
      },
    );
  }
}
