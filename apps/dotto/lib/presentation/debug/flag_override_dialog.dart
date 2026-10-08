import 'package:dotto/foundation/flag/flag.dart';
import 'package:dotto/presentation/common/feature_flag.dart';
import 'package:dotto/presentation/common/flag_override_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// bool のフラグの上書き値を選ぶダイアログ。
final class FlagOverrideDialog extends HookConsumerWidget {
  const new({required this.flag, super.key});

  final Flag<bool> flag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final override = ref.watch(flagOverrideStateProvider)[flag.key];
    final remoteValue = ref.watch(remoteFlagValueProvider(flag));

    Future<void> select({required bool? value}) async {
      Navigator.of(context).pop();
      await ref
          .read(flagOverrideStateProvider.notifier)
          .setOverride(flag, value: value);
    }

    return SimpleDialog(
      title: Text('${flag.description} Override'),
      children: [
        _OverrideOption(
          title: 'Use Remote Config',
          subtitle: 'Remote Config: $remoteValue',
          isSelected: override == null,
          onPressed: () => select(value: null),
        ),
        _OverrideOption(
          title: 'Force true',
          isSelected: override == true,
          onPressed: () => select(value: true),
        ),
        _OverrideOption(
          title: 'Force false',
          isSelected: override == false,
          onPressed: () => select(value: false),
        ),
      ],
    );
  }
}

final class _OverrideOption extends StatelessWidget {
  const new({
    required this.title,
    required this.isSelected,
    required this.onPressed,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return SimpleDialogOption(
      onPressed: onPressed,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle),
        trailing: isSelected ? const Icon(Icons.check) : null,
      ),
    );
  }
}
