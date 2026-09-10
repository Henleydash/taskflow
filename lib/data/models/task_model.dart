import 'package:hive/hive.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';

part 'task_model.g.dart';

/// Hive-persisted DTO. Keeps serialization concerns out of the domain
/// entity — the mapping (fromEntity/toEntity) is what unit tests exercise.
@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final DateTime dueDate;
  @HiveField(4)
  final int priorityIndex;
  @HiveField(5)
  final int categoryIndex;
  @HiveField(6)
  final bool isCompleted;
  @HiveField(7)
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priorityIndex,
    required this.categoryIndex,
    required this.isCompleted,
    required this.createdAt,
  });

  factory TaskModel.fromEntity(Task task) => TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        dueDate: task.dueDate,
        priorityIndex: task.priority.index,
        categoryIndex: task.category.index,
        isCompleted: task.isCompleted,
        createdAt: task.createdAt,
      );

  Task toEntity() => Task(
        id: id,
        title: title,
        description: description,
        dueDate: dueDate,
        priority: Priority.values[priorityIndex],
        category: TaskCategory.values[categoryIndex],
        isCompleted: isCompleted,
        createdAt: createdAt,
      );
}
