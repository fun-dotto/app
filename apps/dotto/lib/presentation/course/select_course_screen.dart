import 'package:dotto/application/register_course_use_case.dart';
import 'package:dotto/application/unregister_course_use_case.dart';
import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/domain_error.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/timetable_item.dart';
import 'package:dotto/domain/entity/timetable_semester.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/component/button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final class SelectCourseScreen extends HookConsumerWidget {
  const new(
    this.semester,
    this.dayOfWeek,
    this.period,
    this.timetableItems, {
    this.onChanged,
    super.key,
  });
  final TimetableSemester semester;
  final DayOfWeek dayOfWeek;
  final Period period;
  final List<TimetableItem> timetableItems;
  final Future<void> Function()? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaving = useState(false);
    Future<void> changeRegistration(TimetableItem item) async {
      if (isSaving.value) return;
      isSaving.value = true;
      try {
        if (item.isAddedToTimetable ?? false) {
          await ref.read(unregisterCourseUseCaseProvider)(item.subject.id);
        } else {
          await ref.read(registerCourseUseCaseProvider)(item.subject.id);
        }
        await onChanged?.call();
        if (context.mounted) Navigator.of(context).pop();
      } on DomainError catch (error) {
        if (!context.mounted) return;
        final message = error.type == DomainErrorType.invalidData
            ? (AppLocalizations.of(context) ?? AppLocalizationsJa())
                  .courseSlotFull
            : (AppLocalizations.of(context) ?? AppLocalizationsJa())
                  .courseRegistrationError;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      } finally {
        if (context.mounted) isSaving.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          (AppLocalizations.of(context) ?? AppLocalizationsJa())
              .courseSlotTitle(semester.label, dayOfWeek.label, period.number),
        ),
      ),
      body: timetableItems.isEmpty
          ? Center(
              child: Text(
                (AppLocalizations.of(context) ?? AppLocalizationsJa())
                    .courseNoSubjects,
              ),
            )
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
                    onPressed: isSaving.value
                        ? null
                        : () => changeRegistration(item),
                    child: Text(
                      isAdded
                          ? (AppLocalizations.of(context) ??
                                    AppLocalizationsJa())
                                .courseRemove
                          : (AppLocalizations.of(context) ??
                                    AppLocalizationsJa())
                                .courseAdd,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
