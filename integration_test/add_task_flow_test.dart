import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';
import 'package:taskflow/l10n/app_localizations.dart';
import 'package:taskflow/presentation/providers/providers.dart';
import 'package:taskflow/presentation/screens/home_screen.dart';

import '../test/helpers/fake_task_repository.dart';

/// End-to-end: user opens the app, adds a task through the real form UI,
/// and sees it rendered in the real list — exercising the full
/// presentation -> provider -> use case -> repository chain in one pass.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('adding a task through the form makes it appear on the home list',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          taskRepositoryProvider.overrideWithValue(FakeTaskRepository()),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: HomeScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No tasks yet'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.widgetWithText(TextFormField, 'Title'), 'Prepare release notes');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Prepare release notes'), findsOneWidget);
    expect(find.text('No tasks yet'), findsNothing);
  });
}
