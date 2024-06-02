import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/view_models/theme_mode_provider.dart';

class ThemeSwitcher extends ConsumerStatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends ConsumerState<ThemeSwitcher> {
  bool animate = false;

  void _toggleTheme() {
    ref.read(themeConfigProvider.notifier).toggleTheme();
    setState(() {
      animate = !animate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeConfigProvider);
    final systemBrightness = MediaQuery.of(context).platformBrightness;

    print(themeMode);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: _toggleTheme,
          child: Container(
            child: themeMode == ThemeMode.system
                ? systemBrightness == Brightness.dark
                    ? const Icon(Icons.dark_mode_outlined)
                    : const Icon(Icons.light_mode_outlined)
                : themeMode == ThemeMode.dark
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
          ),
        ),
        Positioned(
          left: -55,
          top: 2,
          child: TweenAnimationBuilder(
            // 애니메이션을 트리거하기 위해 Key 변경.
            key: ValueKey(animate),
            duration: const Duration(milliseconds: 1300),
            tween: Tween<double>(begin: 1, end: 0),
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Text(
                  themeMode == ThemeMode.system
                      ? "System"
                      : themeMode == ThemeMode.light
                          ? "Light"
                          : "Dark",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
