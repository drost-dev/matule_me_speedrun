part of 'goods_bloc.dart';

sealed class GoodsEvent extends Equatable {
  const GoodsEvent();

  @override
  List<Object?> get props => [];
}

class FetchGoods extends GoodsEvent {
  const FetchGoods();
}

class ToggleFavGood extends GoodsEvent {
  const ToggleFavGood({required this.product});

  final Product product;

  @override
  List<Object?> get props => [product];
}
