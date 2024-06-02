import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/repos/theme_config_repo.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/view_models/theme_mode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // shared_preference 설정
  final preferences = await SharedPreferences.getInstance();
  final repository = ThemeConfigRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        themeConfigProvider.overrideWith(
          () => ThemeConfigViewModel(repository),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeConfigProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'MovieFlix',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
