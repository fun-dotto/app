import 'package:dotto/domain/entity/timetable_period_style.dart';
import 'package:dotto/presentation/course/course_customize_content.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Number only', type: CourseCustomizeContent)
Widget courseCustomizeContentNumberOnly(BuildContext context) =>
    CourseCustomizeContent(
      timetablePeriodStyle: TimetablePeriodStyle.numberOnly,
      onTimetablePeriodStyleChanged: (_) {},
    );

@widgetbook.UseCase(name: 'Number and time', type: CourseCustomizeContent)
Widget courseCustomizeContentNumberAndTime(BuildContext context) =>
    CourseCustomizeContent(
      timetablePeriodStyle: TimetablePeriodStyle.numberAndTime,
      onTimetablePeriodStyleChanged: (_) {},
    );
