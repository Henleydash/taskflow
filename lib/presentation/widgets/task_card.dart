import 'package:flutter/material.dart';

import '../../core/constants/task_visuals.dart';
import '../../core/utils/date_formatter.dart';
import '../../domain/entities/task.dart';
import '../../l10n/app_localizations.dart';
import 'priority_badge.dart';

/// Const-constructible list item — no rebuild unless [task] itself changes,
/// keeping the scrolling list at 60fps even with many items.
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    return Semantics(
      button: true,
      label: task.title,
      child: Card(
        child: ListTile(
          onTap: onTap,
          leading: Semantics(
            label: task.isCompleted ? l10n.markIncomplete : l10n.markComplete,
            button: true,
            child: Checkbox(
              value: task.isCompleted,
              onChanged: (_) => onToggleComplete(),
            ),
          ),
          title: Text(
            task.title,
            style: task.isCompleted
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          subtitle: Row(
            children: [
              Icon(TaskVisuals.categoryIcon(task.category), size: 14),
              const SizedBox(width: 4),
              Text(DateFormatter.short(task.dueDate, localeCode)),
              if (task.isOverdue) ...[
                const SizedBox(width: 6),
                const Icon(Icons.warning_amber, size: 14, color: Colors.red),
              ],
            ],
          ),
          trailing: PriorityBadge(priority: task.priority),
        ),
      ),
    );
  }
}
