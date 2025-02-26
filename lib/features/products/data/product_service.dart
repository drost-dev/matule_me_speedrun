import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

class ProductService {
  List<Product> allProducts = [];

  void toggleFavourite(Product product) {
    allProducts.firstWhere((p) {
      return p.id == product.id;
    }).isFavourite = !product.isFavourite;
  }
}
