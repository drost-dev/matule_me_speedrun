import 'package:matule_me_speedrun/features/products/domain/models/category.dart';

class Product {
  String? id;
  String? name;
  String? desc;
  double? price;
  String? categoryId;
  bool? available;
  Category? category;
  String? imageUrl;
  bool isFavourite = false;
  bool addedToCart = false;

  Product(
      {this.isFavourite = false,
      this.addedToCart = false,
      this.id,
      this.name,
      this.desc,
      this.price,
      this.categoryId,
      this.available,
      this.category,
      this.imageUrl});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    categoryId = json['category_id'];
    available = json['available'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['price'] = price;
    data['category_id'] = categoryId;
    data['available'] = available;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}
