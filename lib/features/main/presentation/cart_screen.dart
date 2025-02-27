import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/main/presentation/bloc/goods/goods_bloc.dart';
import 'package:matule_me_speedrun/features/main/presentation/widgets/cart_product.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GoodsBloc goodsBloc = GetIt.I<GoodsBloc>();

  List<Product> cartProducts = [];

  // final products = [
  //   Product(
  //     id: '1',
  //     name: 'Nike Club Max',
  //     desc: '',
  //     price: 584.95,
  //     imageUrl: 'images/cart_product1.png',
  //   ),
  //   Product(
  //     id: '2',
  //     name: 'Nike Air Max 200',
  //     desc: '',
  //     price: 94.05,
  //     imageUrl: 'images/cart_product1.png',
  //   ),
  //   Product(
  //     id: '3',
  //     name: 'Nike Air Max 270 Essential',
  //     desc: '',
  //     price: 74.95,
  //     imageUrl: 'images/cart_product1.png',
  //   ),
  // ];

  @override
  void initState() {
    if (goodsBloc.state is GoodsLoaded &&
        (goodsBloc.state as GoodsLoaded).cartLoaded) {
      setState(() {
        cartProducts = (goodsBloc.state as GoodsLoaded)
            .products
            .where((element) => element.addedToCart)
            .toList();
      });
    } else {
      goodsBloc.add(const FetchGoods());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(92),
        child: Container(
          padding: const EdgeInsets.only(top: 48, left: 20, right: 20),
          constraints: const BoxConstraints.expand(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.square(
                dimension: 44,
                child: IconButton(
                  onPressed: () {
                    goodsBloc.add(const FetchGoods());
                    context.router.maybePop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: theme.colorScheme.onSurface,
                  ),
                  icon: const ImageIcon(
                    AssetImage('icons/arrow_left.png'),
                  ),
                ),
              ),
              Text(
                'Корзина',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(width: 44),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
          child: BlocConsumer(
            bloc: goodsBloc,
            listener: (context, state) {
              if (state is GoodsLoaded && state.cartLoaded) {
                setState(() {
                  cartProducts = state.products
                      .where((element) => element.addedToCart)
                      .toList();
                });
              }
            },
            builder: (context, state) {
              if (state is GoodsLoaded) {
                return Column(
                  children: [
                    ListView.separated(
                      itemBuilder: (context, index) {
                        return CartProduct(
                          key: ValueKey(cartProducts[index].id),
                          product: cartProducts[index],
                          onDelete: () {
                            goodsBloc.add(
                                ToggleCartGood(product: cartProducts[index]));
                            setState(() {
                              cartProducts.removeAt(index);
                            });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 14);
                      },
                      itemCount: cartProducts.length,
                      shrinkWrap: true,
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
