import '../entities/task.dart';
import '../repositories/task_repository.dart';

class TaskValidationException implements Exception {
  final String message;
  const TaskValidationException(this.message);
  @override
  String toString() => message;
}

/// Validates and persists a new task. Keeping validation here (not in the
/// UI) means the rule is unit-testable and reusable from any entry point.
class AddTask {
  final TaskRepository repository;
  const AddTask(this.repository);

  Future<void> call(Task task) async {
    if (task.title.trim().isEmpty) {
      throw const TaskValidationException('titleRequired');
    }
    await repository.addTask(task);
  }
}
