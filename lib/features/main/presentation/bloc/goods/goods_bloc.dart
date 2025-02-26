import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:matule_me_speedrun/features/database/data/repos/supabase/supabase_repo.dart';
import 'package:matule_me_speedrun/features/products/data/product_service.dart';
import 'package:matule_me_speedrun/features/products/domain/models/category.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

part 'goods_event.dart';
part 'goods_state.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsState> {
  GoodsBloc() : super(GoodsInitial()) {
    SupabaseRepo sbRepo = GetIt.I<SupabaseRepo>();
    // ProductService productService = GetIt.I<ProductService>();

    on<GoodsEvent>((event, emit) async {
      switch (event) {
        case FetchGoods():
          // emit(GoodsLoading());

          var products = await sbRepo.getAllProducts();
          var categories = await sbRepo.getAllCategories();
          // productService.allProducts = products;

          // emit(GoodsLoaded(
          //     products: productService.allProducts, categories: categories));
          emit(GoodsLoaded(
              products: products, categories: categories));

          var favProducts = await sbRepo.checkFavourites(products);
          // productService.allProducts = favProducts;

          emit(GoodsLoaded(
            products: favProducts, // productService.allProducts,
            categories: categories,
            favLoaded: true,
          ));
          break;
        case ToggleFavGood():
          // productService.toggleFavourite(event.product);
          await sbRepo.toggleFavourite(event.product);
          // super.add(const FetchGoods());
          break;
      }
    });
  }
}
