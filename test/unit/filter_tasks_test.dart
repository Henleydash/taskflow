import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/domain/usecases/filter_tasks.dart';

Task _task({required TaskCategory category, required Priority priority, bool completed = false}) =>
    Task(
      id: '${category.name}-${priority.name}',
      title: 't',
      description: '',
      dueDate: DateTime(2026, 1, 1),
      priority: priority,
      category: category,
      isCompleted: completed,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  final tasks = [
    _task(category: TaskCategory.work, priority: Priority.high),
    _task(category: TaskCategory.personal, priority: Priority.low),
    _task(category: TaskCategory.work, priority: Priority.low, completed: true),
  ];

  group('FilterTasks use case', () {
    const filter = FilterTasks();

    test('filters by category', () {
      final result = filter(tasks, category: TaskCategory.work);
      expect(result.length, 2);
      expect(result.every((t) => t.category == TaskCategory.work), isTrue);
    });

    test('filters by priority', () {
      final result = filter(tasks, priority: Priority.low);
      expect(result.length, 2);
    });

    test('filters by completion status', () {
      final result = filter(tasks, completed: true);
      expect(result.length, 1);
      expect(result.first.isCompleted, isTrue);
    });

    test('combines multiple filters', () {
      final result = filter(tasks, category: TaskCategory.work, completed: false);
      expect(result.length, 1);
      expect(result.first.priority, Priority.high);
    });
  });
}
