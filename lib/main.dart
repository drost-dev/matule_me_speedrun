import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/bloc/auth/auth_bloc.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/repos/supabase/supabase_repo.dart';
import 'package:matule_me_speedrun/router/app_router.dart';

void main() async {
  SupabaseRepo sbRepo = await SupabaseRepo.init();
  GetIt.I.registerSingleton(sbRepo);

  AuthBloc authBloc = AuthBloc();
  GetIt.instance.registerLazySingleton(() => authBloc);

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
