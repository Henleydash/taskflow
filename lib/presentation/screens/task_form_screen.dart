import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/priority.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_category.dart';
import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';

/// Screen 3/5 — create or edit a task. flutter_hooks manages local form
/// state so this widget never needs setState / StatefulWidget boilerplate.
class TaskFormScreen extends HookConsumerWidget {
  final Task? existingTask;
  const TaskFormScreen({super.key, this.existingTask});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final titleController =
        useTextEditingController(text: existingTask?.title ?? '');
    final descController =
        useTextEditingController(text: existingTask?.description ?? '');
    final dueDate = useState(existingTask?.dueDate ?? DateTime.now());
    final priority = useState(existingTask?.priority ?? Priority.medium);
    final category = useState(existingTask?.category ?? TaskCategory.work);
    final isSaving = useState(false);

    Future<void> pickDate() async {
      final picked = await showDatePicker(
        context: context,
        initialDate: dueDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      );
      if (picked != null) dueDate.value = picked;
    }

    Future<void> save() async {
      if (!formKey.currentState!.validate()) return;
      isSaving.value = true;
      final notifier = ref.read(taskNotifierProvider.notifier);
      final task = Task(
        id: existingTask?.id ?? const Uuid().v4(),
        title: titleController.text.trim(),
        description: descController.text.trim(),
        dueDate: dueDate.value,
        priority: priority.value,
        category: category.value,
        isCompleted: existingTask?.isCompleted ?? false,
        createdAt: existingTask?.createdAt ?? DateTime.now(),
      );
      final ok = existingTask == null
          ? await notifier.addTask(task)
          : await notifier.updateTask(task);
      isSaving.value = false;
      if (ok && context.mounted) Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(existingTask == null ? l10n.addTask : l10n.editTask),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: l10n.titleLabel),
              validator: (value) =>
                  (value == null || value.trim().isEmpty)
                      ? l10n.titleRequired
                      : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: descController,
              decoration: InputDecoration(labelText: l10n.descriptionLabel),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.dueDateLabel),
              subtitle: Text('${dueDate.value.toLocal()}'.split(' ').first),
              trailing: const Icon(Icons.calendar_today),
              onTap: pickDate,
            ),
            const SizedBox(height: 12),
            Text(l10n.priorityLabel, style: Theme.of(context).textTheme.labelLarge),
            Wrap(
              spacing: 8,
              children: Priority.values.map((p) {
                return ChoiceChip(
                  label: Text(p.name),
                  selected: priority.value == p,
                  onSelected: (_) => priority.value = p,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text(l10n.categoryLabel, style: Theme.of(context).textTheme.labelLarge),
            Wrap(
              spacing: 8,
              children: TaskCategory.values.map((c) {
                return ChoiceChip(
                  label: Text(c.name),
                  selected: category.value == c,
                  onSelected: (_) => category.value = c,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Semantics(
              button: true,
              label: l10n.save,
              child: FilledButton(
                onPressed: isSaving.value ? null : save,
                child: isSaving.value
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
