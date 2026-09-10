import 'package:equatable/equatable.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';

class TaskState extends Equatable {
  final List<Task> tasks;
  final bool isLoading;
  final TaskCategory? categoryFilter;
  final Priority? priorityFilter;
  final String? errorKey;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.categoryFilter,
    this.priorityFilter,
    this.errorKey,
  });

  List<Task> get filteredTasks => tasks.where((t) {
        if (categoryFilter != null && t.category != categoryFilter) {
          return false;
        }
        if (priorityFilter != null && t.priority != priorityFilter) {
          return false;
        }
        return true;
      }).toList();

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  int get pendingCount => tasks.length - completedCount;

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    TaskCategory? categoryFilter,
    Priority? priorityFilter,
    bool clearCategoryFilter = false,
    bool clearPriorityFilter = false,
    String? errorKey,
    bool clearError = false,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      categoryFilter:
          clearCategoryFilter ? null : (categoryFilter ?? this.categoryFilter),
      priorityFilter:
          clearPriorityFilter ? null : (priorityFilter ?? this.priorityFilter),
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
    );
  }

  @override
  List<Object?> get props =>
      [tasks, isLoading, categoryFilter, priorityFilter, errorKey];
}
