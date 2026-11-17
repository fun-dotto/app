import 'package:dotto/domain/entity/academic_area.dart';
import 'package:dotto/domain/entity/academic_class.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/domain/entity/grade.dart';
import 'package:dotto/extension/edge_insets_extension.dart';
import 'package:dotto/presentation/common/error_view.dart';
import 'package:dotto/presentation/common/loading_view.dart';
import 'package:dotto/presentation/common/user_state.dart';
import 'package:dotto/presentation/setting/user_profile_field.dart';
import 'package:dotto_design_system/component/content.dart';
import 'package:dotto_design_system/component/dotto_app_bar.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 学年・コース・クラスのうち [field] の値を、「なし」を含む選択肢から選ぶ画面。
final class UserProfileOptionScreen extends HookConsumerWidget {
  const new({required this.field, super.key});

  final UserProfileField field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);

    return Scaffold(
      appBar: DottoAppBar(title: Text(field.title)),
      body: switch (user) {
        AsyncData(:final DottoUser value) => _FieldOptionList(
          field: field,
          user: value,
        ),
        AsyncError() || AsyncData() => const ErrorView(),
        _ => const LoadingView(),
      },
    );
  }
}

final class _FieldOptionList extends ConsumerWidget {
  const new({required this.field, required this.user});

  final UserProfileField field;
  final DottoUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(userStateProvider.notifier);

    return switch (field) {
      UserProfileField.grade => _OptionList<Grade>(
        options: Grade.values,
        selected: user.grade,
        labelOf: (grade) => grade.label,
        onSelected: notifier.setGrade,
      ),
      UserProfileField.course => _OptionList<AcademicArea>(
        options: AcademicArea.values,
        selected: user.course,
        labelOf: (course) => course.label,
        onSelected: notifier.setCourse,
      ),
      UserProfileField.academicClass => _OptionList<AcademicClass>(
        options: AcademicClass.values,
        selected: user.class_,
        labelOf: (class_) => class_.label,
        onSelected: notifier.setClass,
      ),
    };
  }
}

final class _OptionList<T> extends StatelessWidget {
  const new({
    required this.options,
    required this.selected,
    required this.labelOf,
    required this.onSelected,
  });

  final List<T> options;
  final T? selected;
  final String Function(T option) labelOf;
  final Future<void> Function(T? option) onSelected;

  // 保存に失敗しても表示は元に戻るため、失敗したことだけを伝える
  Future<void> _select(BuildContext context, T? option) async {
    try {
      await onSelected(option);
    } on DomainError {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('保存に失敗しました')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16)
          .withBottomBarInset(context),
      child: DottoContent.flow(
        sections: [
          DottoListSection(
            children: [
              _OptionTile(
                label: 'なし',
                isSelected: selected == null,
                onTap: () => _select(context, null),
              ),
              ...options.map(
                (option) => _OptionTile(
                  label: labelOf(option),
                  isSelected: selected == option,
                  onTap: () => _select(context, option),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _OptionTile extends StatelessWidget {
  const new({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DottoListTile(
      firstLine: Text(label),
      leading: Icon(isSelected ? Icons.check : null),
      onTap: onTap,
    );
  }
}
