import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/presentation/widgets/priority_badge.dart';

import 'test_app_wrapper.dart';

void main() {
  testWidgets('PriorityBadge shows the localized label for high priority', (tester) async {
    await pumpAndSettleTest(
      tester,
      wrapForTest(const Scaffold(body: PriorityBadge(priority: Priority.high))),
    );

    expect(find.text('High'), findsOneWidget);
  });

  testWidgets('PriorityBadge exposes a semantic label for screen readers', (tester) async {
    // Semantics tree is only built while a handle is held — without this,
    // bySemanticsLabel always finds zero nodes even on correct widgets.
    final handle = tester.ensureSemantics();

    await pumpAndSettleTest(
      tester,
      wrapForTest(const Scaffold(body: PriorityBadge(priority: Priority.low))),
    );

    expect(
      find.bySemanticsLabel('Priority: Low'),
      findsOneWidget,
    );

    handle.dispose();
  });
}
