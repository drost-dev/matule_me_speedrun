import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/router/presentation/app_router.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedIndex = 0;

  final routes = const [
    HomeRoute(),
    FavouriteRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AutoTabsRouter(
      routes: routes,
      homeIndex: 0,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        tabsRouter.addListener(() {
          setState(() {
            selectedIndex = tabsRouter.activeIndex;
          });
        });

        return Scaffold(
          extendBody: true,
          body: child,
          bottomNavigationBar: PreferredSize(
            preferredSize: const Size.fromHeight(106),
            child: Container(
              height: 106,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bottom_bar.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 8),
                              blurRadius: 24,
                              color: Color.fromRGBO(91, 158, 225, 0.6),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.router.push(const CartRoute());
                          },
                          icon: ImageIcon(
                            const AssetImage('assets/icons/cart.png'),
                            size: 24,
                            color: theme.colorScheme.onSurface,
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: theme.colorScheme.blue,
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    left: 31,
                    right: 31,
                    bottom: 30,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox.square(
                                  dimension: 24,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 0;
                                      });
                                      tabsRouter.setActiveIndex(selectedIndex);
                                    },
                                    icon: ImageIcon(
                                      const AssetImage('assets/icons/home.png'),
                                      size: 24,
                                      color: selectedIndex == 0
                                          ? theme.colorScheme.blue
                                          : theme.colorScheme.grey,
                                    ),
                                    style: TextButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 24,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 1;
                                      });
                                      tabsRouter.setActiveIndex(selectedIndex);
                                    },
                                    icon: ImageIcon(
                                      const AssetImage(
                                          'assets/icons/heart2.png'),
                                      size: 24,
                                      color: selectedIndex == 1
                                          ? theme.colorScheme.blue
                                          : theme.colorScheme.grey,
                                    ),
                                    style: TextButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 138 / 375,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox.square(
                                  dimension: 24,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 2;
                                      });
                                      tabsRouter.setActiveIndex(selectedIndex);
                                    },
                                    icon: ImageIcon(
                                      const AssetImage('assets/icons/bell.png'),
                                      size: 24,
                                      color: selectedIndex == 2
                                          ? theme.colorScheme.blue
                                          : theme.colorScheme.grey,
                                    ),
                                    style: TextButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 24,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = 3;
                                      });
                                      tabsRouter.setActiveIndex(selectedIndex);
                                    },
                                    icon: ImageIcon(
                                      const AssetImage(
                                          'assets/icons/person.png'),
                                      size: 24,
                                      color: selectedIndex == 3
                                          ? theme.colorScheme.blue
                                          : theme.colorScheme.grey,
                                    ),
                                    style: TextButton.styleFrom(
                                      splashFactory: NoSplash.splashFactory,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
