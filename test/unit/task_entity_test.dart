import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';

Task _buildTask({bool completed = false, DateTime? dueDate}) => Task(
      id: '1',
      title: 'Buy groceries',
      description: 'Milk, eggs, bread',
      dueDate: dueDate ?? DateTime.now().add(const Duration(days: 1)),
      priority: Priority.medium,
      category: TaskCategory.personal,
      isCompleted: completed,
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  group('Task entity', () {
    test('isOverdue is false for a future due date', () {
      final task =
          _buildTask(dueDate: DateTime.now().add(const Duration(days: 2)));
      expect(task.isOverdue, isFalse);
    });

    test('isOverdue is true for a past due date when not completed', () {
      final task =
          _buildTask(dueDate: DateTime.now().subtract(const Duration(days: 1)));
      expect(task.isOverdue, isTrue);
    });

    test('isOverdue is false for a past due date when completed', () {
      final task = _buildTask(
        completed: true,
        dueDate: DateTime.now().subtract(const Duration(days: 1)),
      );
      expect(task.isOverdue, isFalse);
    });

    test('copyWith overrides only the given fields', () {
      final task = _buildTask();
      final updated = task.copyWith(title: 'New title');
      expect(updated.title, 'New title');
      expect(updated.description, task.description);
      expect(updated.id, task.id);
    });

    test('two tasks with identical fields are equal (Equatable)', () {
      final a = _buildTask(dueDate: DateTime(2026, 5, 1));
      final b = _buildTask(dueDate: DateTime(2026, 5, 1));
      expect(a, equals(b));
    });
  });
}
