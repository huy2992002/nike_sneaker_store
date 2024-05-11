import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  /// Object product
  ///
  /// include
  /// [uuid], [name], [imagePath], [price], [quantity], [description], [isBestSeller], [category] arguments must not be null
  /// and [isFavorite] argument has default value is false
  ProductModel({
    this.uuid,
    this.name,
    this.imagePath,
    this.price,
    this.quantity,
    this.description,
    this.isBestSeller,
    this.category,
    this.isFavorite = false,
    this.productsInSameColor,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        uuid: json['uuid'] as String?,
        name: json['name'] as String?,
        imagePath: json['imagePath'] as String?,
        price: json['price'] != null
            ? double.parse(json['price'].toString())
            : null,
        quantity: json['quantity'] as int?,
        description: json['description'] as String?,
        isBestSeller: json['isBestSeller'] as bool?,
        category: json['category'] as String?,
        productsInSameColor: json['productsInSameColor'] == null
            ? null
            : (json['productsInSameColor'] as List<dynamic>)
                .map((e) => e as String)
                .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (imagePath != null) 'imagePath': imagePath,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (description != null) 'description': description,
      if (isBestSeller != null) 'isBestSeller': isBestSeller,
      if (category != null) 'category': category,
    };
  }

  ProductModel copyWith({
    String? uuid,
    String? name,
    String? imagePath,
    double? price,
    int? quantity,
    String? description,
    bool? isBestSeller,
    String? category,
    bool? isFavorite,
    List<String>? productsInSameColor,
  }) {
    return ProductModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      productsInSameColor: productsInSameColor ?? this.productsInSameColor,
    );
  }

  /// uuid of [ProductModel] , argument must not be duplicated
  String? uuid;

  /// Name of product
  String? name;

  /// Product image assets path
  String? imagePath;

  /// price of product
  double? price;

  /// quantity of product
  int? quantity;

  /// description of product
  String? description;

  /// If [isBestSeller] argument is true product will be the best seller
  bool? isBestSeller;

  /// category of product
  String? category;

  /// If [isBestSeller] argument is true product has been liked
  bool isFavorite;

  List<String>? productsInSameColor;

  @override
  List<Object?> get props => [
        uuid,
        name,
        imagePath,
        price,
        quantity,
        description,
        imagePath,
        category,
        isFavorite,
        productsInSameColor
      ];
}
