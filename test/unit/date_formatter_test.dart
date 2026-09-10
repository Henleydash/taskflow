import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:taskflow/core/utils/date_formatter.dart';

void main() {
  // intl's DateFormat needs locale data explicitly loaded outside of a
  // running Flutter app (where flutter_localizations does this for you).
  setUpAll(() async {
    await initializeDateFormatting();
  });

  group('DateFormatter', () {
    test('short() formats an English date as "MMM d, y"', () {
      final result = DateFormatter.short(DateTime(2026, 3, 15), 'en');
      expect(result, contains('2026'));
      expect(result, contains('15'));
    });

    test('isToday() returns true for the current date', () {
      expect(DateFormatter.isToday(DateTime.now()), isTrue);
    });

    test('isToday() returns false for a date a week ago', () {
      final aWeekAgo = DateTime.now().subtract(const Duration(days: 7));
      expect(DateFormatter.isToday(aWeekAgo), isFalse);
    });
  });
}
