import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/screens/sign_in/widgets/input_field.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onSurface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: SizedBox.expand(
          child: Container(
            padding: const EdgeInsets.only(top: 66, left: 20),
            alignment: Alignment.bottomLeft,
            child: SizedBox.square(
              dimension: 44,
              child: IconButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: theme.colorScheme.surface,
                ),
                icon: const ImageIcon(
                  AssetImage('icons/arrow_left.png'),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 11, left: 20, right: 20, bottom: 47),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 416),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    constraints: const BoxConstraints(minHeight: 94),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Привет!',
                          style: theme.textTheme.displayMedium,
                        ),
                        Text(
                          'Заполните Свои данные или продолжите через социальные медиа',
                          style: theme.textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 292),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          constraints: const BoxConstraints(minHeight: 218),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                constraints:
                                    const BoxConstraints(minHeight: 190),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InputField(
                                      title: "Email",
                                      hintText: "xyz@gmail.com",
                                    ),
                                    InputField(
                                      title: "Пароль",
                                      hintText: "••••••••",
                                      obsecureText: true,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Восстановить',
                                style: theme.textTheme.labelLarge,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: theme.colorScheme.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              "Войти",
                              style: theme.textTheme.titleMedium?.copyWith(
                                height: 22/14,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Вы впервые? ",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.darkGrey,
                  height: null,
                ),
                children: [
                  TextSpan(
                    text: "Создать пользователя",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurfaceVariant,
                      height: null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
