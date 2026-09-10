import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/presentation/widgets/empty_state.dart';

import 'test_app_wrapper.dart';

void main() {
  testWidgets('EmptyState shows the empty-list icon and hint text',
      (tester) async {
    await pumpAndSettleTest(
      tester,
      wrapForTest(const Scaffold(body: EmptyState())),
    );

    expect(find.byIcon(Icons.checklist_rtl), findsOneWidget);
    expect(find.text('No tasks yet'), findsOneWidget);
  });
}
