import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'MovieFlix',
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
