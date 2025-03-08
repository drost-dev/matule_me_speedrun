import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({
    super.key,
    required this.product,
    this.onDelete,
    this.onAmountChanged,
  });

  final Product product;
  final Function()? onDelete;
  final Function(int amount)? onAmountChanged;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  bool showAmount = false;
  bool showDelete = false;

  bool isAnimating = false;

  late int amount = widget.product.cart!.amount!;

  Timer? _debounce;

  void _debounceAmount() {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(Duration(milliseconds: 500), () {
      widget.onAmountChanged?.call(amount);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

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
          //amount
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
                    if (amount < 5) {
                      setState(() {
                        amount++;
                      });
                      _debounceAmount();
                    }
                  },
                  child: ImageIcon(
                    const AssetImage('assets/icons/plus.png'),
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
                      _debounceAmount();
                    }
                  },
                  child: SizedBox(
                    height: 14,
                    child: ImageIcon(
                      const AssetImage('assets/icons/minus.png'),
                      color: theme.colorScheme.onSurface,
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //product
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              onEnd: () {
                setState(() {
                  isAnimating = false;
                });
              },
              margin: EdgeInsets.only(
                right: showDelete ? 10 : 0,
                left: showAmount ? 10 : 0,
              ),
              width: (showAmount || showDelete)
                  ? 267 * MediaQuery.of(context).size.width / 375
                  : 335 * MediaQuery.of(context).size.width / 375,
              height: 104,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.onSurface,
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(widget.product.imageUrl!),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.name!,
                          style:
                              theme.textTheme.bodyLarge?.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.product.category!.name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 11, fontWeight: FontWeight.w200),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      child: Text(
                    "${widget.product.price! * amount}₽",
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 11),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ),
          //delete
          GestureDetector(
            onTap: () {
              widget.onDelete?.call();
            },
            child: AnimatedContainer(
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
                  const AssetImage('assets/icons/trash_bin.png'),
                  size: 20,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
