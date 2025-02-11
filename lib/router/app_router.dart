import 'package:auto_route/auto_route.dart';
import 'package:matule_me_speedrun/screens/forgot_pass/forgot_pass_screen.dart';
import 'package:matule_me_speedrun/screens/otp_verification/otp_verification_screen.dart';
import 'package:matule_me_speedrun/screens/sign_in/sign_in_screen.dart';
import 'package:matule_me_speedrun/screens/sign_up/sign_up_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignInRoute.page, path: '/signin', initial: true),
        AutoRoute(page: SignUpRoute.page, path: '/signup'),
        AutoRoute(page: ForgotPassRoute.page, path: '/forgot'),
        AutoRoute(page: OtpVerificationRoute.page, path: '/otp'),
      ];
}
