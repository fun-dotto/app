import 'dart:async';

import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/presentation/setting/option_select_dialog.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:material_ui/material_ui.dart';

/// 学年・コース・クラスを設定するセクション。
final class UserProfileSection extends StatelessWidget {
  const new({
    required this.user,
    required this.onGradeSelected,
    required this.onCourseSelected,
    required this.onClassSelected,
    super.key,
  });

  final DottoUser user;
  final Future<void> Function(Grade? grade) onGradeSelected;
  final Future<void> Function(AcademicArea? course) onCourseSelected;
  final Future<void> Function(AcademicClass? class_) onClassSelected;

  @override
  Widget build(BuildContext context) {
    return DottoListSection(
      header: const Text('あなたの情報'),
      children: [
        _ProfileTile<Grade>(
          title: '学年',
          options: Grade.values,
          selected: user.grade,
          labelOf: (grade) => grade.label,
          onSelected: onGradeSelected,
        ),
        _ProfileTile<AcademicArea>(
          title: 'コース',
          options: AcademicArea.values,
          selected: user.course,
          labelOf: (course) => course.label,
          onSelected: onCourseSelected,
        ),
        _ProfileTile<AcademicClass>(
          title: 'クラス',
          options: AcademicClass.values,
          selected: user.class_,
          labelOf: (class_) => class_.label,
          onSelected: onClassSelected,
        ),
      ],
    );
  }
}

final class _ProfileTile<T> extends StatelessWidget {
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
    final selected = this.selected;
    return DottoListTile(
      firstLine: Text(title),
      leading: const Icon(Icons.school),
      secondLine: Text(selected == null ? '未設定' : labelOf(selected)),
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
