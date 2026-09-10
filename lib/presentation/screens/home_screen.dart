import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/entities/task.dart';
import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';
import '../widgets/empty_state.dart';
import '../widgets/filter_bar.dart';
import '../widgets/task_card.dart';
import 'settings_screen.dart';
import 'task_detail_screen.dart';
import 'task_form_screen.dart';

/// Screen 2/5 — task list with category filtering.
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(taskNotifierProvider);
    final notifier = ref.read(taskNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myTasks),
        actions: [
          Semantics(
            button: true,
            label: l10n.settings,
            child: IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          FilterBar(
            selected: state.categoryFilter,
            onChanged: notifier.setCategoryFilter,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.filteredTasks.isEmpty
                    ? const EmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        itemCount: state.filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = state.filteredTasks[index];
                          return TaskCard(
                            key: ValueKey(task.id),
                            task: task,
                            onTap: () => _openDetail(context, task),
                            onToggleComplete: () =>
                                notifier.toggleCompletion(task),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: Semantics(
        button: true,
        label: l10n.addTask,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const TaskFormScreen()),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, Task task) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
    );
  }
}
