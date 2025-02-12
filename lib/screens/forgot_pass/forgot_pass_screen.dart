import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/bloc/auth/auth_bloc.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/router/app_router.dart';
import 'package:matule_me_speedrun/widgets/input_field.dart';

@RoutePage()
class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  String _email = '';
  final _emailKey = GlobalKey<FormFieldState>();

  final _authBloc = GetIt.I<AuthBloc>();

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
                onPressed: () {
                  context.router.maybePop();
                },
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
      body: Container(
        constraints: const BoxConstraints(minHeight: 272),
        padding: const EdgeInsets.only(top: 11, left: 20, right: 20),
        child: BlocConsumer(
          bloc: _authBloc,
          listener: (context, state) {
            switch (state) {
              case AuthWaitingCode():
                showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(const Duration(seconds: 3), () {
                      if (context.mounted) context.router.replace(const OtpVerificationRoute());
                    });

                    return Dialog(
                      insetPadding: EdgeInsets.zero,
                      child: Container(
                        width: 335,
                        height: 196,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 30,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onSurface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: theme.colorScheme.blue,
                              radius: 22,
                              child: const ImageIcon(
                                AssetImage('icons/mail.png'),
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              constraints: const BoxConstraints(minHeight: 68),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Проверьте Ваш Email',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      height: 20 / 16,
                                      letterSpacing: 0,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    'Мы Отправили Код Восстановления Пароля На Вашу Электронную Почту.',
                                    style: theme.textTheme.titleLarge
                                        ?.copyWith(height: 24 / 16),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).whenComplete(() {
                  context.router.replace(const OtpVerificationRoute());
                });
                break;
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  constraints: const BoxConstraints(minHeight: 94),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Забыл пароль',
                        style: theme.textTheme.displayMedium,
                      ),
                      Text(
                        'Введите свою учетную запись\nдля сброса',
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                InputField(
                  formKey: _emailKey,
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  hintText: "xyz@gmail.com",
                  validator: (value) {
                    if (RegExp(r"^[a-zA-Z0-9.]+\@[a-zA-Z0-9.]+\.[a-zA-Z0-9]{2,}")
                            .stringMatch(_email) ==
                        value) {
                      return null;
                    } else {
                      return "Введите корректный email!";
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      if ((_emailKey.currentState?.validate() ?? false)) {
                        _authBloc.add(AuthRequestCode(email: _email));
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      "Отправить",
                      style: theme.textTheme.titleMedium?.copyWith(
                        height: 22 / 14,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
