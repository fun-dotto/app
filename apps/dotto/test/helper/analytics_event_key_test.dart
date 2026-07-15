import 'package:dotto/helper/analytics_event_key.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('macSupportButtonTapped has a stable analytics value', () {
    expect(
      AnalyticsEventKey.macSupportButtonTapped.value,
      'mac_support_button_tapped',
    );
  });

  test('all analytics event values use snake_case', () {
    final snakeCase = RegExp(r'^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$');

    for (final key in AnalyticsEventKey.values) {
      expect(
        key.value,
        matches(snakeCase),
        reason: '${key.name}: ${key.value}',
      );
    }
  });
}
