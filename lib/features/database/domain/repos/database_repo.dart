import 'package:matule_me_speedrun/features/products/domain/models/category.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

abstract class DatabaseRepo {
  bool isSignedIn();
  Future<void> signIn({required String email, required String password});
  Future<void> signUp(
      {required String name, required String email, required String password});
  Future<void> sendOtp({required String email});
  Future<void> verifyOtp({required String email, required String code});
  Future<List<Product>> getAllProducts();
  String getProductImage(Product product);
  Future<List<Product>> checkFavourites(List<Product> products);
  Future<void> toggleFavourite(Product product);
  Future<List<Product>> checkCart(List<Product> products);
  Future<void> toggleCart(Product product);
  Future<List<Category>> getAllCategories();
}
