import '../entities/task.dart';
import '../repositories/task_repository.dart';
import 'add_task.dart';

class UpdateTask {
  final TaskRepository repository;
  const UpdateTask(this.repository);

  Future<void> call(Task task) async {
    if (task.title.trim().isEmpty) {
      throw const TaskValidationException('titleRequired');
    }
    await repository.updateTask(task);
  }
}
