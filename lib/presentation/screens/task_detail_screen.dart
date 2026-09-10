import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/constants/task_visuals.dart';
import '../../core/utils/date_formatter.dart';
import '../../domain/entities/task.dart';
import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';
import '../widgets/priority_badge.dart';
import 'task_form_screen.dart';

/// Screen 4/5 — full task detail, edit and delete entry points.
class TaskDetailScreen extends ConsumerWidget {
  final Task task;
  const TaskDetailScreen({super.key, required this.task});

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirmTitle),
        content: Text(l10n.deleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(taskNotifierProvider.notifier).deleteTask(task.id);
      if (context.mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.taskDetails),
        actions: [
          Semantics(
            button: true,
            label: l10n.editTask,
            child: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => TaskFormScreen(existingTask: task),
                ),
              ),
            ),
          ),
          Semantics(
            button: true,
            label: l10n.delete,
            child: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context, ref),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Icon(TaskVisuals.categoryIcon(task.category)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(task.title, style: Theme.of(context).textTheme.headlineSmall),
              ),
              PriorityBadge(priority: task.priority),
            ],
          ),
          const SizedBox(height: 16),
          if (task.description.isNotEmpty) Text(task.description),
          const SizedBox(height: 16),
          Text('${l10n.dueDateLabel}: ${DateFormatter.short(task.dueDate, localeCode)}'),
        ],
      ),
    );
  }
}
