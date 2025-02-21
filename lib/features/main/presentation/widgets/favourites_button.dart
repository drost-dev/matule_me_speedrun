import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/features/router/presentation/app_router.dart';

class FavouritesButton extends StatelessWidget {
  const FavouritesButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox.square(
      dimension: 44,
      child: IconButton(
        onPressed: () {
          context.router.push(const FavouriteRoute());
        },
        icon: ImageIcon(
          const AssetImage('icons/heart3.png'),
          size: 24,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        style: TextButton.styleFrom(
          backgroundColor: theme.colorScheme.onSurface,
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
