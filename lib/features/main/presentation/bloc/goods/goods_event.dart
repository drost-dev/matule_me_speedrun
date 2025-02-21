part of 'goods_bloc.dart';

sealed class GoodsEvent extends Equatable {
  const GoodsEvent();

  @override
  List<Object?> get props => [];
}

class FetchGoods extends GoodsEvent {
  const FetchGoods();
}

class ToogleFavGood extends GoodsEvent {
  const ToogleFavGood();
}