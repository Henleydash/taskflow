import '../entities/task.dart';

/// Abstract contract the domain layer depends on. Implemented by the data
/// layer so use cases and providers stay persistence-agnostic and testable.
abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
}
