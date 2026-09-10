import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/datasources/task_local_datasource.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/usecases/add_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/toggle_task_completion.dart';
import '../../domain/usecases/update_task.dart';
import 'task_notifier.dart';
import 'task_state.dart';

/// Overridden in main() once the Hive box is open, and overridden with a
/// fake in tests — nothing above this line ever imports Hive directly.
final taskBoxProvider = Provider<Box<TaskModel>>((ref) {
  throw UnimplementedError('taskBoxProvider must be overridden');
});

final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  return HiveTaskLocalDataSource(ref.watch(taskBoxProvider));
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(ref.watch(taskLocalDataSourceProvider));
});

final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return TaskNotifier(
    getTasks: GetTasks(repo),
    addTaskUseCase: AddTask(repo),
    updateTaskUseCase: UpdateTask(repo),
    deleteTaskUseCase: DeleteTask(repo),
    toggleTaskCompletion: ToggleTaskCompletion(repo),
  )..load();
});
