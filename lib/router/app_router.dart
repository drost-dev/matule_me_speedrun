import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/screens/category/category_screen.dart';
import 'package:matule_me_speedrun/screens/favourite/favourite_screen.dart';
import 'package:matule_me_speedrun/screens/forgot_pass/forgot_pass_screen.dart';
import 'package:matule_me_speedrun/screens/home/home_screen.dart';
import 'package:matule_me_speedrun/screens/otp_verification/otp_verification_screen.dart';
import 'package:matule_me_speedrun/screens/popular/popular_screen.dart';
import 'package:matule_me_speedrun/screens/root/root_screen.dart';
import 'package:matule_me_speedrun/screens/sign_in/sign_in_screen.dart';
import 'package:matule_me_speedrun/screens/sign_up/sign_up_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        
        AutoRoute(page: SignUpRoute.page, path: '/signup'),
        AutoRoute(page: ForgotPassRoute.page, path: '/forgot'),
        AutoRoute(page: OtpVerificationRoute.page, path: '/otp'),

        AutoRoute(
          page: RootRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: SignInRoute.page, path: 'signin'),
            AutoRoute(page: FavouriteRoute.page, path: 'favourite'),
          ],
          initial: true,
        ),

        AutoRoute(page: PopularRoute.page, path: '/popular'),
        AutoRoute(page: CategoryRoute.page, path: '/category'),
      ];
}
