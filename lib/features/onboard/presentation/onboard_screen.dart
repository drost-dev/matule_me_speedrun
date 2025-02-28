import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/onboard/domain/models/onboard_data.dart';
import 'package:matule_me_speedrun/features/router/presentation/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() {
    return _OnboardScreenState();
  }
}

class _OnboardScreenState extends State<OnboardScreen> {
  // int currentIndex = 0;

  Queue<OnboardData> data = Queue<OnboardData>();

  @override
  void initState() {
    data.addAll([
      const OnboardData(),
      const OnboardData(
        title: 'Начнем путешествие',
        desc: 'Умная, великолепная и модная коллекция Изучите сейчас',
      ),
      const OnboardData(
        title: 'У вас есть сила, чтобы',
        desc: 'В вашей комнате много красивых и привлекательных растений',
      ),
    ]);
    var sp = GetIt.I<SharedPreferences>();
    for (int i = 0; i < sp.getInt('onboardIndex')!; i++) {
      data.removeFirst();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.blue,
              theme.disabledColor,
            ],
          ),
        ),
        padding: const EdgeInsets.only(top: 70, bottom: 36),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Stack(
            key: ValueKey(data.length),
            children: [
              if (data.length == 3)
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'ДОБРО\nПОЖАЛОВАТЬ',
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontSize: 30,
                      color: theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Align(
                alignment:
                    data.length == 3 ? Alignment.center : Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 302,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'images/onboard_${(data.length - 3).abs()}.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    data.first.title == null
                        ? const SizedBox(height: 26)
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 60),
                                Text(
                                  data.first.title ?? '',
                                  textAlign: TextAlign.center,
                                  style:
                                      theme.textTheme.displayMedium?.copyWith(
                                    fontSize: 34,
                                    height: 44.2 / 34,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  data.first.desc ?? '',
                                  textAlign: TextAlign.center,
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 5,
                      width: 123,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if ((data.length - 3).abs() == index) {
                            return Container(
                              height: 5,
                              width: 43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: theme.colorScheme.onSurface,
                              ),
                            );
                          } else {
                            return Container(
                              height: 5,
                              width: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: theme.disabledColor,
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 12);
                        },
                        itemCount: 3,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  constraints: const BoxConstraints.expand(height: 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                    onPressed: () {
                      if (data.length > 1) {
                        setState(() {
                          data.removeFirst();
                        });
                        var sp = GetIt.I<SharedPreferences>();
                        sp.setInt('onboardIndex', 3 - data.length);
                      } else {
                        context.router.replace(const HomeRoute());
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: Text(
                      data.length == 3 ? 'Начать' : 'Далее',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
