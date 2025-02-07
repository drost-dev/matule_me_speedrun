import 'package:auto_route/auto_route.dart';
import 'package:matule_me_speedrun/screens/sign_in/sign_in_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SignInRoute.page,
          path: '/signin',
          initial: true
        ),
      ];
}
