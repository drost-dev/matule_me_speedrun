import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.title,
    required this.hintText,
    this.obsecureText,
  });

  final String title;
  final String hintText;
  final bool? obsecureText;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText = widget.obsecureText ?? false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(minHeight: 90),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
              height: 20 / 16,
            ),
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextFormField(
              style: theme.textTheme.titleMedium,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: theme.textTheme.titleMedium,
                filled: true,
                fillColor: theme.colorScheme.surface,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14),
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxHeight: 24,
                  maxWidth: 24 + 14,
                ),
                suffixIcon: widget.obsecureText != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: const ImageIcon(
                            AssetImage("icons/eye.png"),
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
