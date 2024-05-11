import 'package:equatable/equatable.dart';

abstract class CartInfoEvent extends Equatable {}

class CartInfoStarted extends CartInfoEvent {
  CartInfoStarted({
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  final String email;
  final String phoneNumber;
  final String address;

  @override
  List<Object?> get props => [email, phoneNumber, address];
}

class CartInfoEmailChanged extends CartInfoEvent {
  CartInfoEmailChanged({required this.email});

  final String email;

  @override
  List<Object?> get props => [email];
}

class CartInfoAddressChanged extends CartInfoEvent {
  CartInfoAddressChanged({required this.address});

  final String address;

  @override
  List<Object?> get props => [address];
}

class CartInfoPhoneChanged extends CartInfoEvent {
  CartInfoPhoneChanged({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}
