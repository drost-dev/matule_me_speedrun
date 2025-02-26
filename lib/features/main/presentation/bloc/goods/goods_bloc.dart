import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/database/data/repos/supabase/supabase_repo.dart';
import 'package:matule_me_speedrun/features/products/domain/models/category.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

part 'goods_event.dart';
part 'goods_state.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsState> {
  GoodsBloc() : super(GoodsInitial()) {
    SupabaseRepo sbRepo = GetIt.I<SupabaseRepo>();

    on<GoodsEvent>((event, emit) async {
      switch (event) {
        case FetchGoods():
          emit(GoodsLoading());

          var products = await sbRepo.getAllProducts();
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
        case ToggleFavGood():
          await sbRepo.toggleFavourite(event.product);
          break;
        case ToggleCartGood():
          await sbRepo.toggleCart(event.product);
          break;
      }
    });
  }
}
