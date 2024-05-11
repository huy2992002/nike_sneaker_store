import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_event.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_state.dart';

class CartInfoBloc extends Bloc<CartInfoEvent, CartInfoState> {
  CartInfoBloc() : super(const CartInfoState()) {
    on<CartInfoStarted>(_onStarted);
    on<CartInfoEmailChanged>(_onEmailChanged);
    on<CartInfoPhoneChanged>(_onPhoneChanged);
    on<CartInfoAddressChanged>(_onAddressChanged);
  }

  Future<void> _onStarted(
      CartInfoStarted event, Emitter<CartInfoState> emit) async {
    bool canAction = isValid(
      email: event.email,
      address: event.address,
      phoneNumber: event.phoneNumber,
    );
    emit(state.copyWith(
      email: event.email,
      phoneNumber: event.phoneNumber,
      address: event.address,
      canAction: canAction,
    ));
  }

  Future<void> _onEmailChanged(
      CartInfoEmailChanged event, Emitter<CartInfoState> emit) async {
    bool canAction = isValid(
      email: event.email,
      address: state.address,
      phoneNumber: state.phoneNumber,
    );
    emit(state.copyWith(
      email: event.email,
      canAction: canAction,
    ));
  }

  Future<void> _onPhoneChanged(
      CartInfoPhoneChanged event, Emitter<CartInfoState> emit) async {
    bool canAction = isValid(
      email: state.email,
      address: state.address,
      phoneNumber: event.phoneNumber,
    );
    emit(state.copyWith(
      phoneNumber: event.phoneNumber,
      canAction: canAction,
    ));
  }

  Future<void> _onAddressChanged(
      CartInfoAddressChanged event, Emitter<CartInfoState> emit) async {
    bool canAction = isValid(
      email: state.email,
      address: event.address,
      phoneNumber: state.phoneNumber,
    );
    emit(state.copyWith(
      address: event.address,
      canAction: canAction,
    ));
  }

  bool isValid({
    required String email,
    required String address,
    required String phoneNumber,
  }) {
    return RegExp(NSConstants.emailPattern).hasMatch(email) &&
        address.isNotEmpty &&
        RegExp(NSConstants.phonePattern).hasMatch(phoneNumber);
  }
}
