import '../entities/priority.dart';
import '../entities/task.dart';
import '../entities/task_category.dart';

/// Pure, side-effect-free filtering logic extracted so it can be unit
/// tested without touching the repository or widget tree.
class FilterTasks {
  const FilterTasks();

  List<Task> call(
    List<Task> tasks, {
    TaskCategory? category,
    Priority? priority,
    bool? completed,
  }) {
    return tasks.where((task) {
      if (category != null && task.category != category) return false;
      if (priority != null && task.priority != priority) return false;
      if (completed != null && task.isCompleted != completed) return false;
      return true;
    }).toList();
  }
}
