import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:material_ui/material_ui.dart';

/// 時間割の表示設定。
final class CourseCustomizeContent extends StatelessWidget {
  const new({
    required this.timetablePeriodStyle,
    required this.onTimetablePeriodStyleChanged,
    super.key,
  });

  final TimetablePeriodStyle timetablePeriodStyle;
  final ValueChanged<TimetablePeriodStyle> onTimetablePeriodStyleChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        (AppLocalizations.of(context) ?? AppLocalizationsJa()).courseShowTime,
      ),
      value: timetablePeriodStyle == TimetablePeriodStyle.numberAndTime,
      onChanged: (value) => onTimetablePeriodStyleChanged(
        value
            ? TimetablePeriodStyle.numberAndTime
            : TimetablePeriodStyle.numberOnly,
      ),
    );
  }
}
