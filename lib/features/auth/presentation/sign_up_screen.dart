import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/router/presentation/app_router.dart';
import 'package:matule_me_speedrun/features/auth/presentation/widgets/input_field.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name = '';
  final _nameKey = GlobalKey<FormFieldState>();

  String _email = '';
  final _emailKey = GlobalKey<FormFieldState>();

  String _password = '';
  final _passwordKey = GlobalKey<FormFieldState>();

  bool _isAgreed = false;

  final AuthBloc _authBloc = GetIt.I<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  AssetImage('assets/icons/arrow_left.png'),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 11, left: 20, right: 20, bottom: 47),
        child: BlocConsumer(
          bloc: _authBloc,
          listener: (context, state) {
            switch (state) {
              case AuthSuccess():
                context.router.replace(const HomeRoute());
                break;
              case AuthError():
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: theme.textTheme.bodyMedium,
                    ),
                    backgroundColor: theme.colorScheme.red,
                  ),
                );
                break;
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 514),
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
                              'Регистрация',
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
                        constraints: const BoxConstraints(minHeight: 390),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InputField(
                              formKey: _nameKey,
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                              title: "Ваше имя",
                              hintText: "x x x x x x x x",
                              validator: (value) {
                                if (RegExp(r"[a-zA-Z0-9]{6,}")
                                        .stringMatch(_name) ==
                                    value) {
                                  return null;
                                } else {
                                  return "Введите корректное имя!";
                                }
                              },
                            ),
                            Container(
                              constraints: const BoxConstraints(minHeight: 298),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    constraints:
                                        const BoxConstraints(minHeight: 190),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          constraints: const BoxConstraints(
                                              minHeight: 190),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InputField(
                                                formKey: _emailKey,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _email = value;
                                                  });
                                                },
                                                title: "Email",
                                                hintText: "xyz@gmail.com",
                                                validator: (value) {
                                                  if (RegExp(r"^[a-zA-Z0-9.]+\@[a-zA-Z0-9.]+\.[a-zA-Z0-9]{2,}")
                                                          .stringMatch(
                                                              _email) ==
                                                      value) {
                                                    return null;
                                                  } else {
                                                    return "Введите корректный email!";
                                                  }
                                                },
                                              ),
                                              InputField(
                                                formKey: _passwordKey,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _password = value;
                                                  });
                                                },
                                                title: "Пароль",
                                                hintText: "••••••••",
                                                obsecureText: true,
                                                validator: (value) {
                                                  if (RegExp(r"^[a-zA-Z0-9.]{8,}")
                                                          .stringMatch(
                                                              _password) ==
                                                      value) {
                                                    return null;
                                                  } else {
                                                    return "Введите корректный пароль!";
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _isAgreed = !_isAgreed;
                                          });
                                        },
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                            color: theme.colorScheme.surface,
                                          ),
                                          alignment: Alignment.center,
                                          child: _isAgreed
                                              ? Image.asset(
                                                  'assets/icons/shield.png')
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Flexible(
                                        child: Text(
                                          "Даю согласие на обработку персональных данных",
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: theme.colorScheme.darkGrey,
                                            height: null,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                theme.colorScheme.darkGrey,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: TextButton(
                                      onPressed: () {
                                        if ((_nameKey.currentState
                                                    ?.validate() ??
                                                false) &&
                                            (_emailKey.currentState
                                                    ?.validate() ??
                                                false) &&
                                            (_passwordKey.currentState
                                                    ?.validate() ??
                                                false)) {
                                          _authBloc.add(AuthSignUp(
                                              email: _email,
                                              password: _password,
                                              name: _name));
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: theme.colorScheme.blue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: Text(
                                        "Зарегистрироватеься",
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          height: 22 / 14,
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
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.router.push(const SignInRoute());
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Есть аккаунт? ",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.darkGrey,
                        height: null,
                      ),
                      children: [
                        TextSpan(
                          text: "Войти",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurfaceVariant,
                            height: null,
                          ),
                        ),
                      ],
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
