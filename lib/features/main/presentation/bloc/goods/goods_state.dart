part of 'goods_bloc.dart';

sealed class GoodsState extends Equatable {
  const GoodsState();
  
  @override
  List<Object?> get props => [];
}

final class GoodsInitial extends GoodsState {}

// final class GoodsLoading extends GoodsState {}

final class GoodsError extends GoodsState {
  final String errorMsg;

  const GoodsError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}

final class GoodsLoaded extends GoodsState {
  final List<Product> products;
  final List<Category> categories;

  const GoodsLoaded({required this.products, required this.categories});

  @override
  List<Object?> get props => [products, categories];
}