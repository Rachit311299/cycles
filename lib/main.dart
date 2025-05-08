import 'package:cycles/providers/theme_notifier.dart';
import 'package:cycles/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cycles/router/app_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current theme mode from Riverpod
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Cycles',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Light theme
      darkTheme: AppTheme.darkTheme, // Dark theme
      themeMode: themeMode, // Automatically switches between light & dark mode
      routerConfig: appRouter, // Use GoRouter for navigation
    );
  }
}
