import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';

class ProductCardSmall extends StatefulWidget {
  const ProductCardSmall({super.key});

  @override
  State<ProductCardSmall> createState() => _ProductCardSmallState();
}

class _ProductCardSmallState extends State<ProductCardSmall> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 160,
      height: 184.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.onSurface,
      ),
      padding: const EdgeInsets.only(top: 3, left: 9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 28,
              height: 28,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
              ),
              child: ImageIcon(
                const AssetImage('icons/heart.png'),
                color: theme.colorScheme.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
