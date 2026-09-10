import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'home_screen.dart';

/// Screen 1/5 — brief branded splash, then hands off to HomeScreen.
class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      final timer = Future.delayed(const Duration(milliseconds: 900), () {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      });
      return () => timer.ignore();
    }, const []);

    return Scaffold(
      body: Center(
        child: Semantics(
          label: 'TaskFlow',
          child:
              const Icon(Icons.checklist_rtl, size: 96, color: Colors.indigo),
        ),
      ),
    );
  }
}
