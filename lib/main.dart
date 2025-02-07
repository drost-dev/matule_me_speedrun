import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/router/app_router.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router.config(),
      theme: defaultTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
