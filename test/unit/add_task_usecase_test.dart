import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/domain/usecases/add_task.dart';

import '../helpers/fake_task_repository.dart';

Task _task({String title = 'Write report'}) => Task(
      id: '1',
      title: title,
      description: '',
      dueDate: DateTime(2026, 5, 1),
      priority: Priority.high,
      category: TaskCategory.work,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('AddTask use case', () {
    test('persists a task with a non-empty title', () async {
      final repo = FakeTaskRepository();
      final addTask = AddTask(repo);

      await addTask(_task());

      expect((await repo.getTasks()).length, 1);
    });

    test('throws TaskValidationException for an empty title', () async {
      final repo = FakeTaskRepository();
      final addTask = AddTask(repo);

      expect(
        () => addTask(_task(title: '   ')),
        throwsA(isA<TaskValidationException>()),
      );
    });

    test('does not persist a task that fails validation', () async {
      final repo = FakeTaskRepository();
      final addTask = AddTask(repo);

      try {
        await addTask(_task(title: ''));
      } catch (_) {}

      expect(await repo.getTasks(), isEmpty);
    });
  });
}
