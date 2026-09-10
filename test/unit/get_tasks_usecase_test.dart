import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/domain/usecases/get_tasks.dart';

import '../helpers/fake_task_repository.dart';

Task _task(String id, DateTime due, Priority priority) => Task(
      id: id,
      title: id,
      description: '',
      dueDate: due,
      priority: priority,
      category: TaskCategory.other,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('GetTasks use case', () {
    test('sorts tasks by due date ascending', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task('b', DateTime(2026, 3, 1), Priority.low));
      await repo.addTask(_task('a', DateTime(2026, 1, 1), Priority.low));
      final getTasks = GetTasks(repo);

      final result = await getTasks();

      expect(result.map((t) => t.id).toList(), ['a', 'b']);
    });

    test('breaks ties on the same date by higher priority first', () async {
      final repo = FakeTaskRepository();
      final sameDate = DateTime(2026, 4, 1);
      await repo.addTask(_task('low', sameDate, Priority.low));
      await repo.addTask(_task('high', sameDate, Priority.high));
      final getTasks = GetTasks(repo);

      final result = await getTasks();

      expect(result.first.id, 'high');
    });

    test('returns an empty list when there are no tasks', () async {
      final repo = FakeTaskRepository();
      final getTasks = GetTasks(repo);
      expect(await getTasks(), isEmpty);
    });
  });
}
