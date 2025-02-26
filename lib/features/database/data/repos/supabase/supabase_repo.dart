import 'package:matule_me_speedrun/features/database/domain/repos/database_repo.dart';
import 'package:matule_me_speedrun/features/products/domain/models/cart_item.dart';
import 'package:matule_me_speedrun/features/products/domain/models/category.dart';
import 'package:matule_me_speedrun/features/products/domain/models/fav.dart';
import 'package:matule_me_speedrun/features/products/domain/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepo extends DatabaseRepo {
  late final SupabaseClient _client;

  SupabaseRepo._init(this._client);

  static Future<SupabaseRepo> init() async {
    var sb = await Supabase.initialize(
      url: 'https://uqpmzeeszodaaklmvoxe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxcG16ZWVzem9kYWFrbG12b3hlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzNDQ4MDAsImV4cCI6MjA1NDkyMDgwMH0.kqD92ybsgKPXqD_v19aJNY8vTjS59qQyMXDl6Xa7kKU',
    );

    var repo = SupabaseRepo._init(sb.client);

    return repo;
  }

  @override
  bool isSignedIn() {
    return _client.auth.currentUser != null;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(password: password, email: email);
  }

  @override
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    await _client.auth
        .signUp(password: password, email: email, data: {"name": name});
  }

  @override
  Future<void> sendOtp({required String email}) async {
    await _client.auth.signInWithOtp(email: email);
  }

  @override
  Future<void> verifyOtp({required String email, required String code}) async {
    await _client.auth
        .verifyOTP(email: email, token: code, type: OtpType.email);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    var response = await _client
        .from('product')
        .select('*, category(*)')
        .eq('available', true);

    List<Product> products = [];

    for (int i = 0; i < response.length; i++) {
      products.add(Product.fromJson(response[i]));
      products[i].imageUrl = getProductImage(products[i]);
    }

    return products;
  }

  @override
  Future<List<Product>> checkFavourites(List<Product> products) async {
    if (_client.auth.currentUser != null) {
      var response = await _client
          .from('favs')
          .select('*')
          .eq('user_id', _client.auth.currentUser!.id);
      if (response.isNotEmpty) {
        for (int i = 0; i < response.length; i++) {
          var fav = Fav.fromJson(response[i]);

          int index = products.indexWhere((e) {
            return e.id == fav.productId;
          });

          products[index].isFavourite = true;
        }
      }
    }

    return products;
  }

  @override
  Future<void> toggleFavourite(Product product) async {
    if (_client.auth.currentUser != null) {
      if (product.isFavourite) {
        //убираем из избранных
        await _client
            .from('favs')
            .delete()
            .eq('product_id', product.id!)
            .eq('user_id', _client.auth.currentUser!.id);
      } else {
        //добавляем
        await _client.from('favs').upsert(
              Fav(
                userId: _client.auth.currentUser!.id,
                productId: product.id,
              ).toJson(),
              defaultToNull: true,
            );
      }
    }
  }

  @override
  Future<List<Product>> checkCart(List<Product> products) async {
    if (_client.auth.currentUser != null) {
      var response = await _client
          .from('carts')
          .select('*, product(*)')
          .eq('user_id', _client.auth.currentUser!.id);

      if (response.isNotEmpty) {
        for (int i = 0; i < response.length; i++) {
          var cartItem = CartItem.fromJson(response[i]);

          int index = products.indexWhere((e) {
            return e.id == cartItem.productId;
          });

          products[index].addedToCart = true;
        }
      }
    }

    return products;
  }

  @override
  Future<void> toggleCart(Product product) async {
    if (_client.auth.currentUser != null) {
      if (product.addedToCart) {
        //убираем из корзины
        await _client
            .from('carts')
            .delete()
            .eq('product_id', product.id!)
            .eq('user_id', _client.auth.currentUser!.id);
      } else {
        //добавляем
        await _client.from('carts').upsert(
              CartItem(
                userId: _client.auth.currentUser!.id,
                productId: product.id,
              ).toJson(),
              defaultToNull: true,
            );
      }
    }
  }

  @override
  String getProductImage(Product product) {
    final String publicUrl =
        _client.storage.from('products').getPublicUrl('${product.id}.png');

    return publicUrl;
  }

  @override
  Future<List<Category>> getAllCategories() async {
    var response = await _client.from('category').select('*');

    List<Category> categories = [];

    for (int i = 0; i < response.length; i++) {
      categories.add(Category.fromJson(response[i]));
    }

    return categories;
  }
}
