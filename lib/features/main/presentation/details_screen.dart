import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/cart_button.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

@RoutePage()
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double currentX = 0;
  double currentY = -38;

  int selectedIndex = 0;

  final int a = 176;
  final int b = 38;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.filled(
          onPressed: () {
            context.router.maybePop();
          },
          icon: Image.asset('assets/icons/arrow_left.png',
              color: theme.colorScheme.onSurfaceVariant),
          style: TextButton.styleFrom(
            backgroundColor: theme.colorScheme.onPrimary,
          ),
        ),
        // title: SizedBox(
        //   width: 335,
        //   height: 44,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         'Sneaker Shop',
        //         style: theme.textTheme.titleSmall?.copyWith(
        //             fontWeight: FontWeight.w600,
        //             color: theme.colorScheme.onSurfaceVariant),
        //       ),
        //     ],
        //   ),
        // ),
        actions: [
          const CartButton(hasItems: true),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20)
                    .add(const EdgeInsets.only(top: 26)),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 259,
                      child: Text(
                        widget.product.name!,
                        style: theme.textTheme.headlineLarge
                            ?.apply(color: theme.colorScheme.darkGrey),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.product.category!.name,
                      style: theme.textTheme.titleMedium
                          ?.apply(color: theme.colorScheme.darkGrey),
                    ),
                    const SizedBox(height: 8),
                    Text('₽${widget.product.price}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                            height: null,
                            fontSize: 24,
                            color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 113),
                constraints: const BoxConstraints(minHeight: 161),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //slider 😍😍😍😍😍😍😍
                    // Container(
                    //   height: 77,
                    //   padding: const EdgeInsets.only(left: 12, right: 11),
                    //   child: Stack(
                    //     alignment: Alignment.topCenter,
                    //     children: [
                    //       Image.asset('assets/images/ellipse.png'),
                    //       Positioned(
                    //         left: a - 38.57 / 2 + currentX,
                    //         top: b - 18 - currentY,
                    //         child: Align(
                    //           alignment: Alignment.center,
                    //           child: Transform.rotate(
                    //             angle: (b * b * currentX) / (a * a * currentY),
                    //             child: GestureDetector(
                    //               onHorizontalDragUpdate: (details) {
                    //                 if ((currentX + details.delta.dx).abs() <
                    //                     a - 38.57 / 2 - 10) {
                    //                   setState(() {
                    //                     currentX = currentX + details.delta.dx;
                    //                     currentY = b *
                    //                         sqrt(1 -
                    //                             (currentX * currentX) /
                    //                                 (a * a));
                    //                     currentY *= -1;
                    //                   });
                    //                 }
                    //               },
                    //               child: Container(
                    //                 width: 38.57,
                    //                 height: 18,
                    //                 decoration: BoxDecoration(
                    //                   color: theme.colorScheme.darkGrey,
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.center,
                    //                   children: [
                    //                     Image.asset(
                    //                       'assets/icons/arrow_left.png',
                    //                       color: Colors.white,
                    //                     ),
                    //                     Transform.flip(
                    //                       flipX: true,
                    //                       child: Image.asset(
                    //                         'assets/icons/arrow_left.png',
                    //                         color: Colors.white,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //variants
                    // Container(
                    //   height: 56,
                    //   padding: const EdgeInsets.only(left: 24, right: 14),
                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       return Container(
                    //         width: 56,
                    //         height: 56,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(16),
                    //           color: Colors.white,
                    //           boxShadow: const [
                    //             BoxShadow(
                    //               offset: Offset(0, 4),
                    //               blurRadius: 4,
                    //               color: Color.fromRGBO(0, 0, 0, 0.02),
                    //             ),
                    //           ],
                    //         ),
                    //         alignment: Alignment.center,
                    //         child: Image.asset('assets/images/details_min_$index.png'),
                    //       );
                    //     },
                    //     separatorBuilder: (context, index) {
                    //       return const SizedBox(width: 14);
                    //     },
                    //     itemCount: 5,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 33),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: const BoxConstraints(minHeight: 102),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.desc!,
                      style: theme.textTheme.bodySmall?.copyWith(
                          height: 24 / 14,
                          fontWeight: FontWeight.w400,
                          color: theme.colorScheme.onSurfaceVariant),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Подробнее',
                          style: theme.textTheme.bodySmall?.copyWith(
                              height: 21 / 14,
                              fontWeight: FontWeight.w400,
                              color: theme.colorScheme.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(
            left: 53,
            right: 44,
            top: 133,
            bottom: 440,
            child: CachedNetworkImage(
              imageUrl: widget.product.imageUrl!,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: theme.colorScheme.surface,
        padding: const EdgeInsets.only(left: 48, bottom: 40, right: 27),
        child: Container(
          constraints: const BoxConstraints(minWidth: 300, minHeight: 52),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 52,
                height: 52,
                child: IconButton.filled(
                  onPressed: () {
                    //AutoRouter.of(context).maybePop();
                  },
                  icon: Image.asset('assets/icons/heart2.png',
                      color: theme.colorScheme.onSurfaceVariant),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(217, 217, 217, 0.4),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 208,
                child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 13)
                        .add(const EdgeInsets.only(right: 46, left: 51)),
                    backgroundColor: theme.colorScheme.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          'assets/icons/cart.png',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'В корзину',
                        style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
