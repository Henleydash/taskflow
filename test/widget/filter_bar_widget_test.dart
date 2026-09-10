import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/presentation/widgets/filter_bar.dart';

import 'test_app_wrapper.dart';

void main() {
  testWidgets('FilterBar reports the tapped category', (tester) async {
    TaskCategory? selected;
    await pumpAndSettleTest(
      tester,
      wrapForTest(
        Scaffold(
          body: FilterBar(
            selected: null,
            onChanged: (category) => selected = category,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Work'));
    expect(selected, TaskCategory.work);
  });
}
