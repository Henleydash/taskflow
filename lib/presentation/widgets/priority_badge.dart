import 'package:flutter/material.dart';

import '../../core/constants/task_visuals.dart';
import '../../domain/entities/priority.dart';
import '../../l10n/app_localizations.dart';

class PriorityBadge extends StatelessWidget {
  final Priority priority;
  const PriorityBadge({super.key, required this.priority});

  String _label(AppLocalizations l10n) {
    switch (priority) {
      case Priority.low:
        return l10n.priorityLow;
      case Priority.medium:
        return l10n.priorityMedium;
      case Priority.high:
        return l10n.priorityHigh;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = TaskVisuals.priorityColor(priority);
    final label = _label(l10n);
    return Semantics(
      label: '${l10n.priorityLabel}: $label',
      // Without this, the child Text below also exposes its own "Low"-style
      // semantics node, so a screen reader announces the label twice and
      // bySemanticsLabel() can no longer find a single exact match.
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
