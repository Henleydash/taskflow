import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/repositories/task_repository.dart';

/// In-memory fake used across unit tests instead of mocking Hive — keeps
/// use-case and notifier tests fast and free of platform channels.
class FakeTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];
  bool throwOnGet = false;

  @override
  Future<List<Task>> getTasks() async {
    if (throwOnGet) throw Exception('boom');
    return List.unmodifiable(_tasks);
  }

  @override
  Future<void> addTask(Task task) async => _tasks.add(task);

  @override
  Future<void> updateTask(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) {
      _tasks.add(task);
    } else {
      _tasks[index] = task;
    }
  }

  @override
  Future<void> deleteTask(String id) async =>
      _tasks.removeWhere((t) => t.id == id);
}
