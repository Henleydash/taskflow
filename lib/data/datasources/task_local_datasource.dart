import 'package:hive/hive.dart';

import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> saveTask(TaskModel model);
  Future<void> deleteTask(String id);
}

class HiveTaskLocalDataSource implements TaskLocalDataSource {
  static const boxName = 'tasks';
  final Box<TaskModel> box;

  const HiveTaskLocalDataSource(this.box);

  @override
  Future<List<TaskModel>> getTasks() async => box.values.toList();

  @override
  Future<void> saveTask(TaskModel model) async => box.put(model.id, model);

  @override
  Future<void> deleteTask(String id) async => box.delete(id);
}
