import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [id, name, description, price, imagePath];
}