import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';

@RoutePage()
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int index = 0;

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
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'ДОБРО\nПОЖАЛОВАТЬ',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 30,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 130),
            Container(
              height: 302,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/onboard_$index.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 43,
              child: Divider(
                thickness: 5,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
