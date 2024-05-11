import 'package:nike_sneaker_store/models/product_model.dart';

abstract class DetailEvent {}

class DetailSelectStarted extends DetailEvent {
  DetailSelectStarted({
    required this.product,
  });

  final ProductModel product;
}

class DetailChangeProductPressed extends DetailEvent {
  DetailChangeProductPressed({
    required this.productImage,
  });

  final String? productImage;
}

class DetailFavoritePressed extends DetailEvent {}
