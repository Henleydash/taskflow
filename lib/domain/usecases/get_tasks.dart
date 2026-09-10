import '../entities/task.dart';
import '../repositories/task_repository.dart';

/// Fetches all tasks, sorted by due date then priority (high first).
class GetTasks {
  final TaskRepository repository;
  const GetTasks(this.repository);

  Future<List<Task>> call() async {
    final tasks = await repository.getTasks();
    final sorted = [...tasks];
    sorted.sort((a, b) {
      final byDate = a.dueDate.compareTo(b.dueDate);
      if (byDate != 0) return byDate;
      return b.priority.index.compareTo(a.priority.index);
    });
    return sorted;
  }
}
