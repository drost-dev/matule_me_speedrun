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
  Future<List<Category>> getAllCategories();
}