class CartItem {
  String? id;
  String? userId;
  String? productId;
  int? amount;

  CartItem({this.id, this.userId, this.productId});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    id != null ? data['id'] = id : null;
    data['user_id'] = userId;
    data['product_id'] = productId;
    amount != null ? data['amount'] = amount : null;
    return data;
  }
}
