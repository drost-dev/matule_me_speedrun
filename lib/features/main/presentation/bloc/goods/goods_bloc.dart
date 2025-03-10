import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/database/data/repos/supabase/supabase_repo.dart';
import 'package:matule_me_speedrun/features/products/domain/models/cart_item.dart';
import 'package:matule_me_speedrun/features/products/domain/models/category.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

part 'goods_event.dart';
part 'goods_state.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsState> {
  GoodsBloc() : super(GoodsInitial()) {
    SupabaseRepo sbRepo = GetIt.I<SupabaseRepo>();

    on<GoodsEvent>((event, emit) async {
      switch (event) {
        case GoodsFetch():
          if (event.query == null) emit(GoodsLoading());

          List<Product> products;

          if (event.query == null) {
            products = await sbRepo.getAllProducts();
          } else {
            products = await sbRepo.searchProducts(event.query!);
          }
          var categories = await sbRepo.getAllCategories();

          emit(GoodsLoaded(products: products, categories: categories));

          var favProducts = await sbRepo.checkFavourites(products);

          emit(GoodsLoaded(
            products: favProducts,
            categories: categories,
            favLoaded: true,
          ));

          var cartProducts = await sbRepo.checkCart(favProducts);

          emit(GoodsLoaded(
            products: cartProducts,
            categories: categories,
            favLoaded: true,
            cartLoaded: true,
          ));
          break;
        case UpdateLoadedGoods():
          if (super.state is GoodsLoaded) {
            var state = super.state as GoodsLoaded;
            var updatedProduct = event.updatedGood;

            var updatedProducts = state.products.map((product) {
              if (product.id == updatedProduct.id) {
                return updatedProduct;
              } else {
                return product;
              }
            }).toList();

            emit(GoodsReloaded());

            emit(GoodsLoaded(
              products: updatedProducts,
              categories: state.categories,
              favLoaded: state.favLoaded,
              cartLoaded: state.cartLoaded,
            ));
          }
          break;
        case ToggleFavGood():
          var newProduct = await sbRepo.toggleFavourite(event.product);
          super.add(UpdateLoadedGoods(updatedGood: newProduct));
          break;
        case ToggleCartGood():
          var newProduct = await sbRepo.toggleCart(event.product);
          super.add(UpdateLoadedGoods(updatedGood: newProduct));
          break;
        case UpdateCartAmountGood():
          await sbRepo.updateCartAmount(event.cartItem, event.newAmount);
          break;
        case CreateOrderGood():
          await sbRepo.createOrder(event.products);
          break;
      }
    });
  }
}
