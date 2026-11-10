import 'dart:async';

import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/presentation/common/use_localization.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/setting/option_select_dialog.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 学年・コース・クラスを設定するセクション。
final class UserProfileSection extends HookConsumerWidget {
  const new({required this.user, super.key});

  final DottoUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useLocalization();
    final notifier = ref.read(userStateProvider.notifier);

    // 保存に失敗しても表示は元に戻るため、失敗したことだけを伝える
    Future<void> save(Future<void> Function() update) async {
      try {
        await update();
      } on DomainError {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.settingsSaveFailed)));
      }
    }

    return DottoListSection(
      header: Text(l10n.settingsMyInfo),
      children: [
        _ProfileTile<Grade>(
          title: l10n.settingsGrade,
          options: Grade.values,
          selected: user.grade,
          labelOf: (grade) => grade.label,
          onSelected: (grade) => save(() => notifier.setGrade(grade)),
        ),
        _ProfileTile<AcademicArea>(
          title: l10n.settingsCourse,
          options: AcademicArea.values,
          selected: user.course,
          labelOf: (course) => course.label,
          onSelected: (course) => save(() => notifier.setCourse(course)),
        ),
        _ProfileTile<AcademicClass>(
          title: l10n.settingsClass,
          options: AcademicClass.values,
          selected: user.class_,
          labelOf: (class_) => class_.label,
          onSelected: (class_) => save(() => notifier.setClass(class_)),
        ),
      ],
    );
  }
}

final class _ProfileTile<T> extends HookWidget {
  const new({
    required this.title,
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final String title;
  final List<T> options;
  final T? selected;
  final String Function(T option) labelOf;
  final Future<void> Function(T? option) onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = useLocalization();
    final selected = this.selected;
    return DottoListTile(
      firstLine: Text(title),
      leading: const Icon(Icons.school),
      secondLine: Text(selected == null ? l10n.commonUnset : labelOf(selected)),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () => unawaited(
        showDialog<void>(
          context: context,
          builder: (_) => OptionSelectDialog<T>(
            title: title,
            options: options,
            selected: selected,
            labelOf: labelOf,
            onSelected: onSelected,
          ),
        ),
      ),
    );
  }
}
