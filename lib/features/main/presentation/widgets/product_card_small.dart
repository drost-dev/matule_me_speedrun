import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/main/presentation/bloc/goods/goods_bloc.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

class ProductCardSmall extends StatefulWidget {
  const ProductCardSmall({super.key, this.product});

  final Product? product;

  @override
  State<ProductCardSmall> createState() => _ProductCardSmallState();
}

class _ProductCardSmallState extends State<ProductCardSmall> {
  bool inCart = false;
  late bool isFav = widget.product?.isFavourite ?? false;

  GoodsBloc goodsBloc = GetIt.I<GoodsBloc>();

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
      child: widget.product == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox.square(
                        dimension: 28,
                        child: IconButton(
                          key: widget.key,
                          onPressed: () {
                            setState(() {
                              isFav = !isFav;
                            });
                            if (widget.product != null) {
                              goodsBloc.add(
                                ToggleFavGood(
                                  product: widget.product!,
                                  isFav: isFav,
                                ),
                              );
                            }
                          },
                          icon: ImageIcon(
                            const AssetImage('icons/heart.png'),
                            color: isFav
                                ? theme.colorScheme.red
                                : theme.colorScheme.onSurfaceVariant
                                    .withOpacity(0.3),
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
                      child: Image.network(
                        widget.product!.imageUrl!,
                        fit: BoxFit.fitHeight,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          } else {
                            return AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: frame == null ? 0 : 1,
                              child: child,
                            );
                          }
                        },
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
                          // Text(
                          //   'BEST SELLER',
                          //   style: theme.textTheme.labelLarge?.copyWith(
                          //     fontWeight: FontWeight.w500,
                          //     color: theme.colorScheme.blue,
                          //   ),
                          // ),
                          Text(
                            widget.product?.name ?? 'Nike Air Max',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 16,
                              height: 20 / 16,
                              color: theme.colorScheme.darkGrey,
                            ),
                          ),
                          Text(
                            '₽${widget.product?.price ?? 752.00}',
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
                          inCart = !inCart;
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
                        child: inCart
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
