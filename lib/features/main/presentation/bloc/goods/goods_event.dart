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
  const ToggleFavGood({required this.product, required this.isFav});

  final Product product;
  final bool isFav;

  @override
  List<Object?> get props => [product, isFav];
}
