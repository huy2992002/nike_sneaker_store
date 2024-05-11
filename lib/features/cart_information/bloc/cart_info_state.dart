import 'package:equatable/equatable.dart';

enum CartCheckOutStatus {
  initial,
  checkoutLoading,
  checkoutSuccess,
  checkoutFailure,
}

class CartInfoState extends Equatable {
  const CartInfoState({
    this.email = '',
    this.phoneNumber = '',
    this.address = '',
    this.status = CartCheckOutStatus.initial,
    this.message = '',
    this.canAction = false,
  });

  final String email;
  final String phoneNumber;
  final String address;
  final CartCheckOutStatus status;
  final String message;
  final bool canAction;

  CartInfoState copyWith({
    String? email,
    String? phoneNumber,
    String? address,
    CartCheckOutStatus? status,
    String? message,
    bool? canAction,
  }) {
    return CartInfoState(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      status: status ?? this.status,
      message: message ?? this.message,
      canAction: canAction ?? this.canAction,
    );
  }

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        address,
        status,
        message,
        canAction,
      ];
}
