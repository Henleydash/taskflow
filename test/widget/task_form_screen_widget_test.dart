import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/presentation/screens/task_form_screen.dart';

import 'test_app_wrapper.dart';

void main() {
  testWidgets('TaskFormScreen renders the title and description fields',
      (tester) async {
    await pumpAndSettleTest(tester, wrapForTest(const TaskFormScreen()));

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
  });

  testWidgets('TaskFormScreen shows a validation error for an empty title',
      (tester) async {
    await pumpAndSettleTest(tester, wrapForTest(const TaskFormScreen()));

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Title is required'), findsOneWidget);
  });
}
