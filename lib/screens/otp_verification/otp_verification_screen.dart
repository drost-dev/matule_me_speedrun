import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:matule_me_speedrun/default.dart';

@RoutePage()
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String _code = '';
  late Timer timer;
  int timerValue = 30;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (t.tick > 30) {
        t.cancel();
        setState(() {
          timerValue = 30;
        });
      } else {
        setState(() {
          timerValue--;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
        constraints: const BoxConstraints(minHeight: 313),
        padding: const EdgeInsets.only(top: 11, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              constraints: const BoxConstraints(minHeight: 118),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'OTP проверка',
                    style: theme.textTheme.displayMedium,
                  ),
                  Text(
                    'Пожалуйста, Проверьте Свою Электронную Почту, Чтобы Увидеть Код Подтверждения',
                    style: theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(minHeight: 179),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Text(
                      'OTP Код',
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  OtpTextField(
                    onSubmit: (value) {
                      setState(() {
                        _code = value;
                      });
                    },
                    numberOfFields: 6,
                    margin: EdgeInsets.zero,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    fieldHeight: 99,
                    fieldWidth: 46,
                    textStyle: theme.textTheme.bodyLarge,
                    hasCustomInputDecoration: true,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            BorderSide(color: theme.colorScheme.red, width: 1),
                      ),
                      counterText: '',
                      contentPadding: const EdgeInsets.symmetric(vertical: 37),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        timer = Timer.periodic(const Duration(seconds: 1), (t) {
                          if (t.tick > 30) {
                            t.cancel();
                            setState(() {
                              timerValue = 30;
                            });
                          } else {
                            setState(() {
                              timerValue--;
                            });
                          }
                        });
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Отправить заново',
                          style: theme.textTheme.labelSmall,
                        ),
                        Text(
                          '00:${timerValue.toString().padLeft(2, '0')}',
                          style: theme.textTheme.labelSmall,
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
    );
  }
}
