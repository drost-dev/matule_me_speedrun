import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/default.dart';
import 'package:matule_me_speedrun/features/auth/presentation/bloc/auth_bloc.dart';
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
  final AuthBloc authBloc = GetIt.I<AuthBloc>();

  List<Product> cartProducts = [];

  String getPaymentUrl(String orderId) {
    return "http://192.168.0.179:8000/pay/$orderId";
  }

  @override
  void initState() {
    goodsBloc.add(const GoodsFetch());
    // if (goodsBloc.state is GoodsLoaded &&
    //     (goodsBloc.state as GoodsLoaded).cartLoaded) {
    setState(() {
      cartProducts = (goodsBloc.state as GoodsLoaded)
          .products
          .where((element) => element.addedToCart)
          .toList();
    });
    // } else {
    //   goodsBloc.add(const GoodsFetch());
    // }
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
                    goodsBloc.add(const GoodsFetch());
                    context.router.maybePop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: theme.colorScheme.onSurface,
                  ),
                  icon: const ImageIcon(
                    AssetImage('assets/icons/arrow_left.png'),
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
          padding:
              const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 102),
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
              if (state is GoodsOrderCreated) {
                if (authBloc.state is AuthSuccess) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return PopScope(
                        canPop: false,
                        child: Center(
                          child: SizedBox.square(
                            dimension: 250,
                            // color: theme.colorScheme.onSurface,
                            child: AlertDialog(
                              backgroundColor: theme.colorScheme.onSurface,
                              insetPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.all(20),
                              content: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox.square(
                                    dimension: 160,
                                    child: BarcodeWidget(
                                      padding: EdgeInsets.zero,
                                      data: getPaymentUrl(state.orderId),
                                      barcode: Barcode.qrCode(),
                                      backgroundColor:
                                          theme.colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    'Отсканируйте QR-код для оплаты заказа',
                                    style: theme.textTheme.titleMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              if (state is GoodsOrderConfirmed) {
                setState(() {
                  cartProducts.clear();
                });
                context.router.pop();
              }
            },
            builder: (context, state) {
              switch (state) {
                case GoodsLoaded():
                  return Column(
                    children: [
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CartProduct(
                            key: ValueKey(cartProducts[index].id),
                            product: cartProducts[index],
                            onAmountChanged: (amount) {
                              goodsBloc.add(UpdateCartAmountGood(
                                cartItem: cartProducts[index].cart!,
                                newAmount: amount,
                              ));
                            },
                            onDelete: () {
                              goodsBloc.add(
                                  ToggleCartGood(product: cartProducts[index]));
                              setState(() {
                                cartProducts.removeAt(index);
                              });
                              print(cartProducts[index].cart?.amount);
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
                case GoodsLoading():
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.blue,
                    ),
                  );
                default:
                  return SizedBox();
              }
            },
          ),
        ),
      ),
      extendBody: false,
      bottomSheet: SizedBox.fromSize(
        size: Size.fromHeight(82),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox.fromSize(
            size: Size.fromHeight(50),
            // height: 50,
            // width: 335,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: () {
                  if (cartProducts.isNotEmpty) {
                    goodsBloc.add(CreateOrderGood(products: cartProducts));
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: theme.colorScheme.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Оформить заказ",
                  style: theme.textTheme.titleMedium?.copyWith(
                    height: 22 / 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
