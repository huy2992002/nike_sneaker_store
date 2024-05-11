import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

abstract class CartEvent extends Equatable {}

class CartStarted extends CartEvent {
  CartStarted({required this.userId});
  final String userId;

  @override
  List<Object?> get props => [userId];
}

class CartInsertPressed extends CartEvent {
  CartInsertPressed({
    required this.userId,
    required this.product,
  });

  final String userId;
  final ProductModel product;

  @override
  List<Object?> get props => [userId, product];
}

class CartIncrementPressed extends CartEvent {
  CartIncrementPressed({
    required this.userId,
    required this.product,
  });

  final String userId;
  final ProductModel product;

  @override
  List<Object?> get props => [userId, product];
}

class CartDecrementPressed extends CartEvent {
  CartDecrementPressed({
    required this.userId,
    required this.product,
  });

  final String userId;
  final ProductModel product;

  @override
  List<Object?> get props => [userId, product];
}

class CartCheckoutPressed extends CartEvent {
  CartCheckoutPressed({
    required this.userId,
  });

  final String userId;

  @override
  List<Object?> get props => [userId];
}

class CartRemovePressed extends CartEvent {
  CartRemovePressed({
    required this.userId,
    required this.product,
  });

  final String userId;
  final ProductModel product;

  @override
  List<Object?> get props => [userId, product];
}
