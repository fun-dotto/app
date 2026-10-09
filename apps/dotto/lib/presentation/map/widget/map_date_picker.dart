import 'package:dotto/helper/date_formatter.dart';
import 'package:dotto/l10n/app_localizations.dart';
import 'package:dotto/l10n/app_localizations_ja.dart';
import 'package:dotto_design_system/style/map_colors.dart';
import 'package:dotto_design_system/style/semantic_color.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:material_ui/material_ui.dart';

final class MapDatePicker extends StatelessWidget {
  const new({
    required this.searchDatetime,
    required this.onPeriodButtonTapped,
    required this.onDatePickerConfirmed,
    super.key,
  });
  final DateTime searchDatetime;
  final void Function(DateTime) onPeriodButtonTapped;
  final void Function(DateTime) onDatePickerConfirmed;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final nextSunday = monday.add(const Duration(days: 14, minutes: -1));
    final timeMap = <String, DateTime>{
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapPeriod(1): today
          .add(const Duration(hours: 9)),
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapPeriod(2): today
          .add(const Duration(hours: 10, minutes: 40)),
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapPeriod(3): today
          .add(const Duration(hours: 13, minutes: 10)),
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapPeriod(4): today
          .add(const Duration(hours: 14, minutes: 50)),
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapPeriod(5): today
          .add(const Duration(hours: 16, minutes: 30)),
      (AppLocalizations.of(context) ?? AppLocalizationsJa()).mapCurrentTime:
          today,
    };

    return Row(
      children: [
        ...timeMap.entries.map(
          (item) => Expanded(
            child: Center(
              child: _MapPeriodButton(
                searchDatetime: searchDatetime,
                label: item.key,
                dateTime: item.value,
                onPressed: onPeriodButtonTapped,
              ),
            ),
          ),
        ),
        _MapDatePickerButton(
          searchDatetime: searchDatetime,
          monday: monday,
          nextSunday: nextSunday,
          onConfirmed: onDatePickerConfirmed,
        ),
      ],
    );
  }
}

final class _MapPeriodButton extends StatelessWidget {
  const new({
    required this.searchDatetime,
    required this.label,
    required this.dateTime,
    required this.onPressed,
  });
  final DateTime searchDatetime;
  final String label;
  final DateTime dateTime;
  final void Function(DateTime) onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: searchDatetime == dateTime
            ? MapColors.selectedPeriod
            : null,
        textStyle: Theme.of(context).textTheme.labelMedium,
        padding: EdgeInsets.zero,
      ),
      onPressed: () => onPressed(dateTime),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: searchDatetime == dateTime
              ? SemanticColor.light.accentPrimary
              : SemanticColor.light.labelSecondary,
        ),
      ),
    );
  }
}

final class _MapDatePickerButton extends StatelessWidget {
  const new({
    required this.searchDatetime,
    required this.monday,
    required this.nextSunday,
    required this.onConfirmed,
  });
  final DateTime searchDatetime;
  final DateTime monday;
  final DateTime nextSunday;
  final void Function(DateTime) onConfirmed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelMedium,
        padding: EdgeInsets.zero,
      ),
      onPressed: () async {
        final languageCode =
            WidgetsBinding.instance.platformDispatcher.locale.languageCode;
        final locale = switch (languageCode) {
          'ja' => LocaleType.jp,
          _ => LocaleType.en,
        };
        await DatePicker.showDateTimePicker(
          context,
          minTime: monday,
          maxTime: nextSunday,
          onConfirm: onConfirmed,
          currentTime: searchDatetime,
          locale: locale,
        );
      },
      child: Column(
        children: [
          Text(
            DateFormatter.dateWithoutYear(
              searchDatetime,
              locale: Localizations.localeOf(context).toString(),
            ),
          ),
          Text(
            DateFormatter.timeWithoutSecond(
              searchDatetime,
              locale: Localizations.localeOf(context).toString(),
            ),
          ),
        ],
      ),
    );
  }
}
