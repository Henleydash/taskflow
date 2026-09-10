import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;
  const TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final models = await localDataSource.getTasks();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> addTask(Task task) =>
      localDataSource.saveTask(TaskModel.fromEntity(task));

  @override
  Future<void> updateTask(Task task) =>
      localDataSource.saveTask(TaskModel.fromEntity(task));

  @override
  Future<void> deleteTask(String id) => localDataSource.deleteTask(id);
}
