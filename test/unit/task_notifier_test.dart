import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/domain/usecases/add_task.dart';
import 'package:taskflow/domain/usecases/delete_task.dart';
import 'package:taskflow/domain/usecases/get_tasks.dart';
import 'package:taskflow/domain/usecases/toggle_task_completion.dart';
import 'package:taskflow/domain/usecases/update_task.dart';
import 'package:taskflow/presentation/providers/task_notifier.dart';

import '../helpers/fake_task_repository.dart';

Task _task({String id = '1', TaskCategory category = TaskCategory.work}) =>
    Task(
      id: id,
      title: 'Task $id',
      description: '',
      dueDate: DateTime(2026, 5, 1),
      priority: Priority.medium,
      category: category,
      createdAt: DateTime(2026, 1, 1),
    );

TaskNotifier _buildNotifier(FakeTaskRepository repo) {
  return TaskNotifier(
    getTasks: GetTasks(repo),
    addTaskUseCase: AddTask(repo),
    updateTaskUseCase: UpdateTask(repo),
    deleteTaskUseCase: DeleteTask(repo),
    toggleTaskCompletion: ToggleTaskCompletion(repo),
  );
}

void main() {
  group('TaskNotifier', () {
    test('load() populates state.tasks from the repository', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task());
      final notifier = _buildNotifier(repo);

      await notifier.load();

      expect(notifier.state.tasks.length, 1);
      expect(notifier.state.isLoading, isFalse);
    });

    test('load() sets errorKey when the repository throws', () async {
      final repo = FakeTaskRepository()..throwOnGet = true;
      final notifier = _buildNotifier(repo);

      await notifier.load();

      expect(notifier.state.errorKey, 'loadFailed');
    });

    test('addTask() with a valid task refreshes state and returns true',
        () async {
      final repo = FakeTaskRepository();
      final notifier = _buildNotifier(repo);

      final ok = await notifier.addTask(_task());

      expect(ok, isTrue);
      expect(notifier.state.tasks.length, 1);
    });

    test('addTask() with an empty title sets errorKey and returns false',
        () async {
      final repo = FakeTaskRepository();
      final notifier = _buildNotifier(repo);

      final ok = await notifier.addTask(_task().copyWith(title: ''));

      expect(ok, isFalse);
      expect(notifier.state.errorKey, 'titleRequired');
    });

    test('setCategoryFilter narrows filteredTasks', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task(id: '1', category: TaskCategory.work));
      await repo.addTask(_task(id: '2', category: TaskCategory.personal));
      final notifier = _buildNotifier(repo);
      await notifier.load();

      notifier.setCategoryFilter(TaskCategory.work);

      expect(notifier.state.filteredTasks.length, 1);
      expect(notifier.state.filteredTasks.first.category, TaskCategory.work);
    });

    test('setCategoryFilter(null) clears the filter', () async {
      final repo = FakeTaskRepository();
      await repo.addTask(_task(id: '1', category: TaskCategory.work));
      await repo.addTask(_task(id: '2', category: TaskCategory.personal));
      final notifier = _buildNotifier(repo);
      await notifier.load();
      notifier.setCategoryFilter(TaskCategory.work);

      notifier.setCategoryFilter(null);

      expect(notifier.state.filteredTasks.length, 2);
    });
  });
}
