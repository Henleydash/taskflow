import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/toggle_task_completion.dart';
import '../../domain/usecases/update_task.dart';
import 'task_state.dart';

/// Owns all task state mutation. Screens only ever read state or call these
/// methods — never touch the repository directly — so business rules stay
/// in one testable place.
class TaskNotifier extends StateNotifier<TaskState> {
  final GetTasks getTasks;
  final AddTask addTaskUseCase;
  final UpdateTask updateTaskUseCase;
  final DeleteTask deleteTaskUseCase;
  final ToggleTaskCompletion toggleTaskCompletion;

  TaskNotifier({
    required this.getTasks,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
    required this.toggleTaskCompletion,
  }) : super(const TaskState());

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final tasks = await getTasks();
      state = state.copyWith(tasks: tasks, isLoading: false);
    } catch (_) {
      state = state.copyWith(isLoading: false, errorKey: 'loadFailed');
    }
  }

  Future<bool> addTask(Task task) async {
    try {
      await addTaskUseCase(task);
      await load();
      return true;
    } on TaskValidationException {
      state = state.copyWith(errorKey: 'titleRequired');
      return false;
    }
  }

  Future<bool> updateTask(Task task) async {
    try {
      await updateTaskUseCase(task);
      await load();
      return true;
    } on TaskValidationException {
      state = state.copyWith(errorKey: 'titleRequired');
      return false;
    }
  }

  Future<void> deleteTask(String id) async {
    await deleteTaskUseCase(id);
    await load();
  }

  Future<void> toggleCompletion(Task task) async {
    await toggleTaskCompletion(task);
    await load();
  }

  void setCategoryFilter(TaskCategory? category) {
    state = state.copyWith(
      categoryFilter: category,
      clearCategoryFilter: category == null,
    );
  }

  void setPriorityFilter(Priority? priority) {
    state = state.copyWith(
      priorityFilter: priority,
      clearPriorityFilter: priority == null,
    );
  }
}
