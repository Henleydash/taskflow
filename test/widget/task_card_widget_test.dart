import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/presentation/widgets/task_card.dart';

import 'test_app_wrapper.dart';

Task _task({bool completed = false}) => Task(
      id: '1',
      title: 'Finish CI pipeline',
      description: '',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: Priority.high,
      category: TaskCategory.work,
      isCompleted: completed,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  testWidgets('TaskCard displays the task title', (tester) async {
    await pumpAndSettleTest(
      tester,
      wrapForTest(
        Scaffold(
          body: TaskCard(task: _task(), onTap: () {}, onToggleComplete: () {}),
        ),
      ),
    );

    expect(find.text('Finish CI pipeline'), findsOneWidget);
  });

  testWidgets('TaskCard calls onTap when tapped', (tester) async {
    var tapped = false;
    await pumpAndSettleTest(
      tester,
      wrapForTest(
        Scaffold(
          body: TaskCard(
            task: _task(),
            onTap: () => tapped = true,
            onToggleComplete: () {},
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ListTile));
    expect(tapped, isTrue);
  });

  testWidgets('TaskCard calls onToggleComplete when the checkbox is tapped', (tester) async {
    var toggled = false;
    await pumpAndSettleTest(
      tester,
      wrapForTest(
        Scaffold(
          body: TaskCard(
            task: _task(),
            onTap: () {},
            onToggleComplete: () => toggled = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(Checkbox));
    expect(toggled, isTrue);
  });

  testWidgets('TaskCard strikes through the title when completed', (tester) async {
    await pumpAndSettleTest(
      tester,
      wrapForTest(
        Scaffold(
          body: TaskCard(task: _task(completed: true), onTap: () {}, onToggleComplete: () {}),
        ),
      ),
    );

    final text = tester.widget<Text>(find.text('Finish CI pipeline'));
    expect(text.style?.decoration, TextDecoration.lineThrough);
  });
}
