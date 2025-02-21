import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/features/main/presentation/cart_screen.dart';
import 'package:matule_me_speedrun/features/main/presentation/category_screen.dart';
import 'package:matule_me_speedrun/features/main/presentation/favourite_screen.dart';
import 'package:matule_me_speedrun/features/auth/presentation/forgot_pass_screen.dart';
import 'package:matule_me_speedrun/features/main/presentation/home_screen.dart';
import 'package:matule_me_speedrun/features/auth/presentation/otp_verification_screen.dart';
import 'package:matule_me_speedrun/features/main/presentation/popular_screen.dart';
import 'package:matule_me_speedrun/features/main/presentation/root/root_screen.dart';
import 'package:matule_me_speedrun/features/auth/presentation/sign_in_screen.dart';
import 'package:matule_me_speedrun/features/auth/presentation/sign_up_screen.dart';
import 'package:matule_me_speedrun/features/onboard/presentation/onboard_screen.dart';
import 'package:matule_me_speedrun/features/products/domain/models/category.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardRoute.page, path: '/onboard'),
        AutoRoute(
          page: SignInRoute.page,
          path: '/signin',
          initial: true,
        ),

        AutoRoute(page: SignUpRoute.page, path: '/signup'),
        AutoRoute(page: ForgotPassRoute.page, path: '/forgot'),
        AutoRoute(page: OtpVerificationRoute.page, path: '/otp'),
        AutoRoute(
          page: RootRoute.page,
          path: '/',
          children: [
            AutoRoute(page: HomeRoute.page, path: 'home'),
            AutoRoute(page: FavouriteRoute.page, path: 'favourite'),
          ],
        ),
        
        AutoRoute(page: PopularRoute.page, path: '/popular'),
        AutoRoute(page: CategoryRoute.page, path: '/category'),
        AutoRoute(page: CartRoute.page, path: '/cart'),
      ];
}
