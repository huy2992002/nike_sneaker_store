import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

enum CartViewStatus { initial, loading, success, failure }

extension ExCartViewStatus on CartViewStatus {
  bool get isInitial => this == CartViewStatus.initial;
  bool get isLoading => this == CartViewStatus.loading;
  bool get isSuccess => this == CartViewStatus.success;
  bool get isFailure => this == CartViewStatus.failure;
}

enum CartQuantityStatus {
  initial,
  insertLoading,
  insertSuccess,
  insertFailure,
  incrementLoading,
  incrementSuccess,
  incrementFailure,
  decrementLoading,
  decrementSuccess,
  decrementFailure,
  removeLoading,
  removeSuccess,
  removeFailure,
}

enum CartEventCheckOutStatus {
  checkoutInitial,
  checkoutLoading,
  checkoutSuccess,
  checkoutFailure,
}

class CartState extends Equatable {
  const CartState({
    this.viewStatus = CartViewStatus.initial,
    this.myCarts = const [],
    this.message = '',
    this.cartInsertStatus = CartQuantityStatus.initial,
    this.cartCheckoutStatus = CartEventCheckOutStatus.checkoutInitial,
  });

  final CartViewStatus viewStatus;
  final List<ProductModel> myCarts;
  final CartQuantityStatus cartInsertStatus;
  final CartEventCheckOutStatus cartCheckoutStatus;
  final String message;

  CartState copyWith({
    CartViewStatus? viewStatus,
    List<ProductModel>? myCarts,
    String? message,
    CartQuantityStatus? cartInsertStatus,
    CartEventCheckOutStatus? cartCheckoutStatus,
  }) {
    return CartState(
      viewStatus: viewStatus ?? this.viewStatus,
      myCarts: myCarts ?? this.myCarts,
      message: message ?? this.message,
      cartInsertStatus: cartInsertStatus ?? this.cartInsertStatus,
      cartCheckoutStatus: cartCheckoutStatus ?? this.cartCheckoutStatus,
    );
  }

  @override
  List<Object?> get props => [
        viewStatus,
        myCarts,
        message,
        cartInsertStatus,
        cartCheckoutStatus,
      ];
}
