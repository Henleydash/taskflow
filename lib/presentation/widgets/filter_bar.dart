import 'package:flutter/material.dart';

import '../../domain/entities/task_category.dart';
import '../../l10n/app_localizations.dart';

class FilterBar extends StatelessWidget {
  final TaskCategory? selected;
  final ValueChanged<TaskCategory?> onChanged;

  const FilterBar({super.key, required this.selected, required this.onChanged});

  String _label(AppLocalizations l10n, TaskCategory? category) {
    if (category == null) return l10n.filterAll;
    switch (category) {
      case TaskCategory.work:
        return l10n.categoryWork;
      case TaskCategory.personal:
        return l10n.categoryPersonal;
      case TaskCategory.health:
        return l10n.categoryHealth;
      case TaskCategory.study:
        return l10n.categoryStudy;
      case TaskCategory.other:
        return l10n.categoryOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final options = <TaskCategory?>[null, ...TaskCategory.values];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final option = options[index];
          final label = _label(l10n, option);
          return Semantics(
            button: true,
            selected: option == selected,
            label: label,
            child: ChoiceChip(
              label: Text(label),
              selected: option == selected,
              onSelected: (_) => onChanged(option),
            ),
          );
        },
      ),
    );
  }
}
