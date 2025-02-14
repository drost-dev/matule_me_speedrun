import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';

class ProductCardSmall extends StatefulWidget {
  const ProductCardSmall({super.key});

  @override
  State<ProductCardSmall> createState() => _ProductCardSmallState();
}

class _ProductCardSmallState extends State<ProductCardSmall> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 160,
      height: 184,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.onSurface,
      ),
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(top: 3, left: 9),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox.square(
                  dimension: 28,
                  child: IconButton(
                    onPressed: () {
                      //TODO: add/remove fav
                    },
                    icon: ImageIcon(
                      const AssetImage('icons/heart.png'),
                      color: theme.colorScheme.red,
                      size: 16,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                    ),
                    padding: const EdgeInsets.all(6),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                height: 54,
                child: Image.asset(
                  'images/nike1.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 83,
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BEST SELLER',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.blue,
                      ),
                    ),
                    Text(
                      'Nike Air Max',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 16,
                        height: 20 / 16,
                        color: theme.colorScheme.darkGrey,
                      ),
                    ),
                    Text(
                      '₽752.00',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 16 / 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAdded = !isAdded;
                  });
                },
                child: Container(
                  width: 34,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                    ),
                    color: theme.colorScheme.blue,
                  ),
                  alignment: Alignment.center,
                  child: isAdded
                      ? Padding(
                          padding: const EdgeInsets.all(7),
                          child: ImageIcon(
                            const AssetImage('icons/cart2.png'),
                            color: theme.colorScheme.onSurface,
                          ),
                        )
                      : Text(
                          '+',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.w300,
                            color: theme.colorScheme.onSurface,
                            height: 16 / 32,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
