import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/domain/usecases/add_task.dart';
import 'package:taskflow/domain/usecases/delete_task.dart';
import 'package:taskflow/domain/usecases/toggle_task_completion.dart';
import 'package:taskflow/domain/usecases/update_task.dart';

import '../helpers/fake_task_repository.dart';

Task _task() => Task(
      id: 'abc',
      title: 'Read a book',
      description: '',
      dueDate: DateTime(2026, 6, 1),
      priority: Priority.low,
      category: TaskCategory.other,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('UpdateTask use case', () {
    test('overwrites the stored task with the same id', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task());
      final updateTask = UpdateTask(repo);

      await updateTask(_task().copyWith(title: 'Read two books'));

      final tasks = await repo.getTasks();
      expect(tasks.single.title, 'Read two books');
    });

    test('rejects an empty title', () async {
      final repo = FakeTaskRepository();
      final updateTask = UpdateTask(repo);
      expect(
        () => updateTask(_task().copyWith(title: '')),
        throwsA(isA<TaskValidationException>()),
      );
    });
  });

  group('DeleteTask use case', () {
    test('removes the task with the matching id', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task());
      final deleteTask = DeleteTask(repo);

      await deleteTask('abc');

      expect(await repo.getTasks(), isEmpty);
    });
  });

  group('ToggleTaskCompletion use case', () {
    test('flips isCompleted from false to true', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task());
      final toggle = ToggleTaskCompletion(repo);

      await toggle(_task());

      expect((await repo.getTasks()).single.isCompleted, isTrue);
    });
  });
}
