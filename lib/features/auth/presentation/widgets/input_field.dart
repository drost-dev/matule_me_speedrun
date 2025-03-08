import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.title,
    required this.hintText,
    this.obsecureText,
    required this.onChanged,
    this.validator,
    this.formKey,
  });

  final String? title;
  final String hintText;
  final bool? obsecureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final GlobalKey<FormFieldState>? formKey;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool _obscureText = widget.obsecureText ?? false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(minHeight: widget.title != null ? 80 : 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
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
              key: widget.formKey,
              style: theme.textTheme.titleMedium,
              onChanged: widget.onChanged,
              obscureText: _obscureText,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9.@]")),
              ],
              validator: widget.validator,
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
                            AssetImage('assets/icons/eye.png'),
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
