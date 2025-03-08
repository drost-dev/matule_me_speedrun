part of 'goods_bloc.dart';

sealed class GoodsEvent extends Equatable {
  const GoodsEvent();

  @override
  List<Object?> get props => [];
}

class GoodsFetch extends GoodsEvent {
  const GoodsFetch({this.query});

  final String? query;
}

class UpdateLoadedGoods extends GoodsEvent {
  const UpdateLoadedGoods({required this.updatedGood});

  final Product updatedGood;
}

class ToggleFavGood extends GoodsEvent {
  const ToggleFavGood({
    required this.product,
  });

  final Product product;

  @override
  List<Object?> get props => [product];
}

class ToggleCartGood extends GoodsEvent {
  const ToggleCartGood({required this.product});

  final Product product;

  @override
  List<Object?> get props => [product];
}

class UpdateCartAmountGood extends GoodsEvent {
  const UpdateCartAmountGood({required this.cartItem, required this.newAmount});

  final CartItem cartItem;
  final int newAmount;

  @override
  List<Object?> get props => [cartItem];
}