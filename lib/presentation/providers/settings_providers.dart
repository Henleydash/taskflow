import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Simple settings state — no persistence required by spec, but isolated
/// behind providers so it's swappable for a persisted version later.
final localeProvider = StateProvider<Locale>((ref) => const Locale('fr'));
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
