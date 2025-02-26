import 'package:cycles/providers/theme_notifier.dart';
import 'package:cycles/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cycles/widgets/homepage.dart';
import 'package:cycles/widgets/settingspage.dart';
import 'package:go_router/go_router.dart';
import 'package:cycles/widgets/cycle_view.dart';
import 'package:cycles/providers/cycle_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsPage(),
      ),
      GoRoute(
        path: '/plant-cycle',
        builder: (context, state) => CycleView(
          title: 'Plant Cycle',
          backgroundColor: const Color(0xFFE8F3D6),
          progressBarColor: const Color(0xFF93D253),
          imageBackgroundColor: const Color(0xFF93D253),
          buttonColor: const Color(0xFF93D253),
          cycleProvider: plantCycleProvider,
        ),
      ),
      GoRoute(
        path: '/water-cycle',
        builder: (context, state) => CycleView(
          title: 'Water Cycle',
          backgroundColor: const Color(0xFFE1F5FE),
          progressBarColor: const Color(0xFF4B70EA),
          imageBackgroundColor: const Color(0xFF4B70EA),
          buttonColor: const Color(0xFF4B70EA),
          cycleProvider: waterCycleProvider,
        ),
      ),
      GoRoute(
        path: '/rock-cycle',
        builder: (context, state) => CycleView(
          title: 'Rock Cycle',
          backgroundColor: const Color(0xFFF5E6CA),
          progressBarColor: const Color(0xFFF7DB6A),
          imageBackgroundColor: const Color(0xFFF7DB6A),
          buttonColor: const Color(0xFFF7DB6A),
          cycleProvider: rockCycleProvider,
        ),
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
