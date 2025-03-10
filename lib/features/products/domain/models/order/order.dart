import 'order_product.dart';

class Order {
  String? id;
  DateTime? date;
  String? userId;
  bool? paid;
  List<OrderProduct>? orderProducts;

  Order({this.id, this.date, this.userId, this.paid, this.orderProducts});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'] as String?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        userId: json['user_id'] as String?,
        paid: json['paid'] as bool?,
        orderProducts: (json['order_products'] as List<dynamic>?)
            ?.map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date?.toIso8601String(),
        'user_id': userId,
        'paid': paid,
        'order_products': orderProducts?.map((e) => e.toJson()).toList(),
      };
}
