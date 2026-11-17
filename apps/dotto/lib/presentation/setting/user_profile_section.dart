import 'package:dotto/domain/entity/dotto_user.dart';
import 'package:dotto/extension/go_route_data_extension.dart';
import 'package:dotto/presentation/setting/user_profile_field.dart';
import 'package:dotto/router/routes/setting_routes.dart';
import 'package:dotto_design_system/component/list_section.dart';
import 'package:dotto_design_system/component/list_tile.dart';
import 'package:material_ui/material_ui.dart';

/// 学年・コース・クラスを設定するセクション。
///
/// 各項目は選択画面へ遷移して設定する。
final class UserProfileSection extends StatelessWidget {
  const new({required this.user, super.key});

  final DottoUser user;

  @override
  Widget build(BuildContext context) {
    return DottoListSection(
      header: const Text('あなたの情報'),
      children: [
        _ProfileTile(
          field: UserProfileField.grade,
          valueLabel: user.grade?.label,
        ),
        _ProfileTile(
          field: UserProfileField.course,
          valueLabel: user.course?.label,
        ),
        _ProfileTile(
          field: UserProfileField.academicClass,
          valueLabel: user.class_?.label,
        ),
      ],
    );
  }
}

final class _ProfileTile extends StatelessWidget {
  const new({required this.field, required this.valueLabel});

  final UserProfileField field;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    return DottoListTile(
      firstLine: Text(field.title),
      leading: const Icon(Icons.school),
      secondLine: Text(valueLabel ?? '未設定'),
      trailing: const DottoListTileTrailing.chevron(),
      onTap: () =>
          UserProfileOptionRouteData(field: field).openAsDetail(context),
    );
  }
}
