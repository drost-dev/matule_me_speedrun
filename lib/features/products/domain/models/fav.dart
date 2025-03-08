class Fav {
  String? id;
  DateTime? addedAt;
  String? userId;
  String? productId;

  Fav({this.id, this.addedAt, this.userId, this.productId});

  Fav.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedAt = DateTime.parse(json['added_at']);
    userId = json['user_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    id != null ? data['id'] = id : null;
    addedAt != null ? data['added_at'] : addedAt.toString();
    data['user_id'] = userId;
    data['product_id'] = productId;
    return data;
  }
}
