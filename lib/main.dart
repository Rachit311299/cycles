import 'package:cycles/providers/theme_notifier.dart';
import 'package:cycles/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cycles/widgets/homepage.dart';
import 'package:cycles/widgets/settingspage.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/', // Ensure HomePage is always the starting point
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsPage(),
      ),
    ],
    // Redirect if the user pops the last page
    redirect: (context, state) => null,

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found!')),
    ),
  );

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
      routerConfig: _router, // Use GoRouter for navigation
    );
  }
}
