import 'package:dotto/domain/entity/day_of_week.dart';
import 'package:dotto/domain/entity/period.dart';
import 'package:dotto/domain/entity/room_assignment_index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const index = RoomAssignmentIndex(
    roomNamesBySlotAndTitle: {
      (dayOfWeek: DayOfWeek.monday, period: Period.first, title: '解析学'): '363',
    },
    roomNamesByTitle: {'解析学': '講堂', '線形代数': '495'},
  );

  test('コマと科目名が一致する教室を優先する', () {
    expect(
      index.roomName(
        dayOfWeek: DayOfWeek.monday,
        period: Period.first,
        title: '解析学',
      ),
      '363',
    );
  });

  test('コマが一致しなければ科目名だけで教室を求める', () {
    expect(
      index.roomName(
        dayOfWeek: DayOfWeek.friday,
        period: Period.sixth,
        title: '解析学',
      ),
      '講堂',
    );
    expect(index.roomNameByTitle('線形代数'), '495');
  });

  test('該当する科目がなければ教室を求めない', () {
    expect(
      index.roomName(
        dayOfWeek: DayOfWeek.monday,
        period: Period.first,
        title: '未知',
      ),
      isNull,
    );
  });
}
