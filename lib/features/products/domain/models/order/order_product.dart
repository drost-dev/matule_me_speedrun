import 'package:matule_me_speedrun/features/products/domain/models/product.dart';

class OrderProduct {
  int? amount;
  String? orderId;
  String? productId;
  Product? product;

  OrderProduct({this.amount, this.orderId, this.productId});

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        amount: json['amount'] as int?,
        orderId: json['order_id'] as String?,
        productId: json['product_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'order_id': orderId,
        'product_id': productId,
      };
}
