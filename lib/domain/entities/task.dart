import 'package:equatable/equatable.dart';

import 'priority.dart';
import 'task_category.dart';

/// Pure domain entity — no persistence or framework concerns.
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final Priority priority;
  final TaskCategory category;
  final bool isCompleted;
  final DateTime createdAt;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.category,
    required this.createdAt,
    this.isCompleted = false,
  });

  bool get isOverdue => !isCompleted && dueDate.isBefore(DateTime.now());

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    TaskCategory? category,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        priority,
        category,
        isCompleted,
        createdAt,
      ];
}
