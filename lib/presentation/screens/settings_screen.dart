import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/providers.dart';
import '../providers/settings_providers.dart';

/// Screen 5/5 — language + theme toggles, and lightweight statistics
/// derived from the same task state the home screen reads.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeModeProvider);
    final taskState = ref.watch(taskNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.statistics, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              _StatChip(label: l10n.totalTasks, value: taskState.tasks.length),
              const SizedBox(width: 8),
              _StatChip(
                  label: l10n.pendingTasks, value: taskState.pendingCount),
              const SizedBox(width: 8),
              _StatChip(
                  label: l10n.completedTasks, value: taskState.completedCount),
            ],
          ),
          const Divider(height: 32),
          ListTile(
            title: Text(l10n.language),
            trailing: Semantics(
              label: l10n.language,
              child: DropdownButton<Locale>(
                value: locale,
                items: const [
                  DropdownMenuItem(
                      value: Locale('fr'), child: Text('Français')),
                  DropdownMenuItem(value: Locale('en'), child: Text('English')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    ref.read(localeProvider.notifier).state = value;
                  }
                },
              ),
            ),
          ),
          SwitchListTile(
            title: Text(l10n.darkMode),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state =
                  value ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        label: '$label: $value',
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                Text('$value',
                    style: Theme.of(context).textTheme.headlineSmall),
                Text(label, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
