import 'package:cycles/providers/theme_notifier.dart';
import 'package:cycles/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cycles/widgets/homepage.dart';
import 'package:cycles/widgets/settingspage.dart';
import 'package:cycles/widgets/profilepage.dart';
import 'package:go_router/go_router.dart';
import 'package:cycles/widgets/cycle_view.dart';
import 'package:cycles/providers/cycle_provider.dart';
import 'package:cycles/widgets/cycle_menu_view.dart';
import 'package:cycles/widgets/games/cycle_builder_game.dart';
import 'package:cycles/widgets/games/cycle_games_menu.dart';
import 'package:cycles/widgets/games/game_option.dart';
import 'package:cycles/widgets/games/cycle_trivia_game.dart';
import 'package:cycles/providers/trivia_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(path: '/settings', builder: (context, state) => SettingsPage()),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/plant-cycle',
        builder:
            (context, state) => const CycleMenuView(
              title: 'Plant Cycle',
              backgroundColor: Color(0xFFE8F3D6),
              buttonColor: Color(0xFF93D253),
              cycleType: 'plant',
            ),
      ),
      GoRoute(
        path: '/plant-cycle/learn',
        builder:
            (context, state) => CycleView(
              title: 'Plant Cycle',
              backgroundColor: const Color(0xFFE8F3D6),
              progressBarColor: const Color(0xFF93D253),
              imageBackgroundColor: const Color(0xFF93D253),
              buttonColor: const Color(0xFF93D253),
              cycleType: 'plant',
              cycleProvider: plantCycleProvider,
            ),
      ),
      GoRoute(
        path: '/plant-cycle/games',
        builder:
            (context, state) => CycleGamesMenu(
              cycleTitle: 'Plant Cycle',
              backgroundColor: const Color(0xFFE8F3D6),
              buttonColor: const Color(0xFF93D253),
              games: [
                GameOption(
                  title: 'Cycle Builder',
                  description: 'Arrange the stages in correct order',
                  icon: Icons.sort,
                  route: '/plant-cycle/games/builder',
                ),
              ],
            ),
      ),
      GoRoute(
        path: '/plant-cycle/trivia',
        builder:
            (context, state) => Consumer(
              builder: (context, ref, child) {
                final questions = ref.watch(plantCycleTriviaProvider);
                return CycleTriviaGame(
                  title: 'Plant Cycle Trivia',
                  backgroundColor: const Color(0xFFE8F3D6),
                  buttonColor: const Color(0xFF93D253),
                  questions: questions,
                );
              },
            ),
      ),
      GoRoute(
        path: '/plant-cycle/games/builder',
        builder:
            (context, state) => Consumer(
              builder: (context, ref, child) {
                final cycleNotifier = ref.read(plantCycleProvider.notifier);
                return CycleBuilderGame(
                  title: 'Plant Cycle Builder',
                  backgroundColor: const Color(0xFFE8F3D6),
                  buttonColor: const Color(0xFF93D253),
                  stages:
                      cycleNotifier.stages
                          .map(
                            (stage) => CycleStageItem(
                              name: stage.name,
                              imageAsset: stage.imageAsset,
                              correctOrder: cycleNotifier.stages.indexOf(stage),
                            ),
                          )
                          .toList(),
                );
              },
            ),
      ),
      // Water Cycle Routes
      GoRoute(
        path: '/water-cycle',
        builder:
            (context, state) => const CycleMenuView(
              title: 'Water Cycle',
              backgroundColor: Color(0xFFB9F5FF),
              buttonColor: Color(0xFF22A9E0),
              cycleType: 'water',
            ),
      ),
      GoRoute(
        path: '/water-cycle/learn',
        builder:
            (context, state) => CycleView(
              title: 'Water Cycle',
              backgroundColor: const Color(0xFFB9F5FF),
              progressBarColor: const Color(0xFF4B70EA),
              imageBackgroundColor: const Color(0xFF22A9E0),
              buttonColor: const Color(0xFF22A9E0),
              cycleType: 'water',
              cycleProvider: waterCycleProvider,
            ),
      ),
      GoRoute(
        path: '/water-cycle/games',
        builder:
            (context, state) => CycleGamesMenu(
              cycleTitle: 'Water Cycle',
              backgroundColor: const Color(0xFFB9F5FF),
              buttonColor: const Color(0xFF22A9E0),
              games: [
                GameOption(
                  title: 'Cycle Builder',
                  description: 'Arrange the stages in correct order',
                  icon: Icons.sort,
                  route: '/water-cycle/games/builder',
                ),
              ],
            ),
      ),
      GoRoute(
        path: '/water-cycle/trivia',
        builder:
            (context, state) => Consumer(
              builder: (context, ref, child) {
                final questions = ref.watch(waterCycleTriviaProvider);
                return CycleTriviaGame(
                  title: 'Water Cycle Trivia',
                  backgroundColor: const Color(0xFFB9F5FF),
                  buttonColor: const Color(0xFF22A9E0),
                  questions: questions,
                );
              },
            ),
      ),
      GoRoute(
        path: '/water-cycle/games/builder',
        builder:
            (context, state) => Consumer(
              builder: (context, ref, child) {
                final cycleNotifier = ref.read(waterCycleProvider.notifier);
                return CycleBuilderGame(
                  title: 'Water Cycle Builder',
                  backgroundColor: const Color(0xFFB9F5FF),
                  buttonColor: const Color(0xFF22A9E0),
                  stages:
                      cycleNotifier.stages
                          .map(
                            (stage) => CycleStageItem(
                              name: stage.name,
                              imageAsset: stage.imageAsset,
                              correctOrder: cycleNotifier.stages.indexOf(stage),
                            ),
                          )
                          .toList(),
                );
              },
            ),
      ),
      // Rock Cycle Routes
      GoRoute(
        path: '/rock-cycle',
        builder:
            (context, state) => const CycleMenuView(
              title: 'Rock Cycle',
              backgroundColor: Color(0xFFF5E6CA),
              buttonColor: Color(0xFF996A42),
              cycleType: 'rock',
            ),
      ),
      GoRoute(
        path: '/rock-cycle/learn',
        builder:
            (context, state) => CycleView(
              title: 'Rock Cycle',
              backgroundColor: const Color(0xFFF5E6CA),
              progressBarColor: const Color(0xFFC58956),
              imageBackgroundColor: const Color(0xFF996A42),
              buttonColor: const Color(0xFF996A42),
              cycleType: 'rock',
              cycleProvider: rockCycleProvider,
            ),
      ),
      GoRoute(
        path: '/rock-cycle/games',
        builder:
            (context, state) => CycleGamesMenu(
              cycleTitle: 'Rock Cycle',
              backgroundColor: const Color(0xFFF5E6CA),
              buttonColor: const Color(0xFF996A42),
              games: [
                GameOption(
                  title: 'Cycle Builder',
                  description: 'Arrange the stages in correct order',
                  icon: Icons.sort,
                  route: '/rock-cycle/games/builder',
                ),
              ],
            ),
      ),
      GoRoute(
        path: '/rock-cycle/games/builder',
        builder:
            (context, state) => Consumer(
              builder: (context, ref, child) {
                final cycleNotifier = ref.read(rockCycleProvider.notifier);
                return CycleBuilderGame(
                  title: 'Rock Cycle Builder',
                  backgroundColor: const Color(0xFFF5E6CA),
                  buttonColor: const Color(0xFF996A42),
                  stages:
                      cycleNotifier.stages
                          .map(
                            (stage) => CycleStageItem(
                              name: stage.name,
                              imageAsset: stage.imageAsset,
                              correctOrder: cycleNotifier.stages.indexOf(stage),
                            ),
                          )
                          .toList(),
                );
              },
            ),
      ),
    ],
    // Redirect if the user pops the last page
    redirect: (context, state) => null,

    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Page not found!'))),
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
