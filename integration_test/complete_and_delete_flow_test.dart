import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:taskflow/domain/entities/priority.dart';
import 'package:taskflow/domain/entities/task.dart';
import 'package:taskflow/domain/entities/task_category.dart';
import 'package:taskflow/l10n/app_localizations.dart';
import 'package:taskflow/presentation/providers/providers.dart';
import 'package:taskflow/presentation/screens/home_screen.dart';

import '../test/helpers/fake_task_repository.dart';

/// End-to-end: with one seeded task, the user opens its detail screen and
/// deletes it, and the home list reflects the deletion after navigating
/// back — covering navigation plus the delete confirmation dialog.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('deleting a task from its detail screen removes it from the list',
      (tester) async {
    final repo = FakeTaskRepository();
    await repo.addTask(
      Task(
        id: 'seed-1',
        title: 'Renew domain',
        description: '',
        dueDate: DateTime.now().add(const Duration(days: 5)),
        priority: Priority.medium,
        category: TaskCategory.other,
        createdAt: DateTime.now(),
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [taskRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Renew domain'), findsOneWidget);

    await tester.tap(find.text('Renew domain'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Renew domain'), findsNothing);
    expect(find.text('No tasks yet'), findsOneWidget);
  });
}
