import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onSurface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: GestureDetector(
          onTap: () {
            context.router.maybePop();
          },
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
      ),
      body: Container(
        constraints: const BoxConstraints(minHeight: 272),
        padding: const EdgeInsets.only(top: 11, left: 20, right: 20),
        child: Column(
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
                    print('чиназес');
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
        ),
      ),
    );
  }
}
