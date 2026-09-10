import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/data/models/task_model.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';

void main() {
  group('TaskModel mapping', () {
    final task = Task(
      id: '42',
      title: 'Ship the release',
      description: 'Tag v1.2.0',
      dueDate: DateTime(2026, 7, 4),
      priority: Priority.high,
      category: TaskCategory.work,
      isCompleted: true,
      createdAt: DateTime(2026, 1, 1),
    );

    test('fromEntity captures every field as its enum index', () {
      final model = TaskModel.fromEntity(task);
      expect(model.id, '42');
      expect(model.priorityIndex, Priority.high.index);
      expect(model.categoryIndex, TaskCategory.work.index);
      expect(model.isCompleted, isTrue);
    });

    test('toEntity round-trips back to an equal Task', () {
      final model = TaskModel.fromEntity(task);
      final roundTripped = model.toEntity();
      expect(roundTripped, equals(task));
    });
  });
}
