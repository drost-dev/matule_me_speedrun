import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/router/presentation/app_router.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, this.hasItems = false});

  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.square(
      dimension: 44,
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              context.router.push(const CartRoute());
            },
            icon: ImageIcon(
              const AssetImage('assets/icons/cart.png'),
              size: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            style: TextButton.styleFrom(
              backgroundColor: theme.colorScheme.onSurface,
              padding: const EdgeInsets.all(10),
            ),
          ),
          if (hasItems)
            Positioned.fill(
              top: 3,
              left: 2,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.red,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
