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
          var products = await sbRepo.getAllProducts();
          var categories = await sbRepo.getAllCategories();
          emit(GoodsLoaded(products: products, categories: categories));
          break;
        case ToogleFavGood():
          
          break;
      }
    });
  }
}
