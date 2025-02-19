import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({
    super.key,
  });

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  bool showAmount = false;
  bool showDelete = false;

  bool isAnimating = false;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onPanUpdate: (details) {
        if (!isAnimating) {
          // print('свайп');
          if (details.delta.dx > 0) {
            // print('вправо');
            if (showDelete) {
              // print('-удаление');
              setState(() {
                showDelete = false;
                isAnimating = true;
              });
            } else {
              if (!showAmount) {
                // print('+количество');
                setState(() {
                  showAmount = true;
                  isAnimating = true;
                });
              }
            }
          } else {
            // print('влево');
            if (showAmount) {
              // print('-количество');
              setState(() {
                showAmount = false;
                isAnimating = true;
              });
            } else {
              if (!showDelete) {
                // print('+удаление');
                setState(() {
                  showDelete = true;
                  isAnimating = true;
                });
              }
            }
          }
        }
      },
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            onEnd: () {
              setState(() {
                isAnimating = false;
              });
            },
            width: showAmount ? 58 : 0,
            height: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.blue,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      amount++;
                    });
                  },
                  child: ImageIcon(
                    const AssetImage('icons/plus.png'),
                    size: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(amount.toString()),
                GestureDetector(
                  onTap: () {
                    if (amount > 1) {
                      setState(() {
                        amount--;
                      });
                    }
                  },
                  child: SizedBox(
                    height: 2,
                    child: ImageIcon(
                      const AssetImage('icons/minus.png'),
                      color: theme.colorScheme.onSurface,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            onEnd: () {
              setState(() {
                isAnimating = false;
              });
            },
            margin: EdgeInsets.only(
                right: showDelete ? 10 : 0, left: showAmount ? 10 : 0),
            width: (showAmount || showDelete) ? 267 : 335,
            height: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.onSurface,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            onEnd: () {
              setState(() {
                isAnimating = false;
              });
            },
            width: showDelete ? 58 : 0,
            height: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.red,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: 18,
              height: 20,
              child: ImageIcon(
                const AssetImage('icons/trash_bin.png'),
                size: 20,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
