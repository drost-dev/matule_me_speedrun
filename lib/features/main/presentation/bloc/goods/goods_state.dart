part of 'goods_bloc.dart';

sealed class GoodsState extends Equatable {
  const GoodsState();

  @override
  List<Object> get props => [];
}

final class GoodsInitial extends GoodsState {}

final class GoodsLoading extends GoodsState {}

final class GoodsError extends GoodsState {
  final String errorMsg;

  const GoodsError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

final class GoodsLoaded extends GoodsState {
  final List<Product> products;
  final List<Category> categories;
  final bool favLoaded;
  final bool cartLoaded;

  const GoodsLoaded({
    required this.products,
    required this.categories,
    this.favLoaded = false,
    this.cartLoaded = false,
  });

  @override
  List<Object> get props => [products, categories, favLoaded, cartLoaded];
}

final class GoodsReloaded extends GoodsState {}

final class GoodsOrderCreated extends GoodsState {
  final String orderId;

  const GoodsOrderCreated({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

final class GoodsOrderConfirmed extends GoodsState {}