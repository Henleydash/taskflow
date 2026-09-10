import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ToggleTaskCompletion {
  final TaskRepository repository;
  const ToggleTaskCompletion(this.repository);

  Future<void> call(Task task) async {
    await repository.updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }
}
