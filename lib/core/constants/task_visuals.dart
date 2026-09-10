import 'package:flutter/material.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task_category.dart';

/// Centralizes color/icon mapping so widgets never hardcode presentation
/// per-enum-value logic — one place to update, one place to test.
class TaskVisuals {
  TaskVisuals._();

  static Color priorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.orange;
      case Priority.high:
        return Colors.red;
    }
  }

  static IconData categoryIcon(TaskCategory category) {
    switch (category) {
      case TaskCategory.work:
        return Icons.work_outline;
      case TaskCategory.personal:
        return Icons.person_outline;
      case TaskCategory.health:
        return Icons.favorite_outline;
      case TaskCategory.study:
        return Icons.school_outlined;
      case TaskCategory.other:
        return Icons.label_outline;
    }
  }
}
