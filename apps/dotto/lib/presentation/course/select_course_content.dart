import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:material_ui/material_ui.dart';

/// 時間割の 1 コマに登録できる科目の一覧。
final class SelectCourseContent extends StatelessWidget {
  const new({
    required this.semester,
    required this.dayOfWeek,
    required this.period,
    required this.timetableItems,
    required this.isSaving,
    required this.onRegistrationToggled,
    super.key,
  });

  final TimetableSemester semester;
  final DayOfWeek dayOfWeek;
  final Period period;
  final List<TimetableItem> timetableItems;
  final bool isSaving;
  final ValueChanged<TimetableItem> onRegistrationToggled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsJa();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.courseSlotTitle(semester.label, dayOfWeek.label, period.number),
        ),
      ),
      body: timetableItems.isEmpty
          ? Center(child: Text(l10n.courseNoSubjects))
          : ListView.builder(
              itemCount: timetableItems.length,
              itemBuilder: (context, index) {
                final item = timetableItems[index];
                final isAdded = item.isAddedToTimetable ?? false;
                return ListTile(
                  title: Text(item.subject.name),
                  trailing: DottoButton(
                    type: isAdded
                        ? DottoButtonType.outlined
                        : DottoButtonType.contained,
                    onPressed: isSaving
                        ? null
                        : () => onRegistrationToggled(item),
                    child: Text(isAdded ? l10n.courseRemove : l10n.courseAdd),
                  ),
                );
              },
            ),
    );
  }
}
