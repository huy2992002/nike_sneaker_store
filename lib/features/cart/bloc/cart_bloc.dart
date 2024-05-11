// ignore_for_file: avoid_function_literals_in_foreach_calls, cascade_invocations

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';
import 'package:nike_sneaker_store/services/handle_error/error_extension.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this.productRepository, this.userRepository)
      : super(const CartState()) {
    on<CartStarted>(_onStarted);
    on<CartInsertPressed>(_onAddToCart);
    on<CartIncrementPressed>(_onPlusProduct);
    on<CartDecrementPressed>(_onLessProduct);
    on<CartCheckoutPressed>(_onRemoveCart);
    on<CartRemovePressed>(_onRemoveProduct);
  }

  ProductRepository productRepository;
  UserRepository userRepository;

  Future<void> _onStarted(CartStarted event, Emitter<CartState> emit) async {
    emit(state.copyWith(viewStatus: CartViewStatus.loading));
    try {
      final myCarts =
          await productRepository.getIdProductCart(event.userId) ?? [];

      emit(state.copyWith(
        viewStatus: CartViewStatus.success,
        myCarts: myCarts,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        viewStatus: CartViewStatus.failure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        viewStatus: CartViewStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onAddToCart(
      CartInsertPressed event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartInsertStatus: CartQuantityStatus.insertLoading));
    try {
      final isValid = state.myCarts.any((e) =>
          e.uuid == event.product.uuid &&
          e.imagePath == event.product.imagePath);
      if (isValid) {
        List<ProductModel> products = [...state.myCarts];
        products.forEach((element) {
          if (element.uuid == event.product.uuid &&
              element.imagePath == event.product.imagePath) {
            element.quantity = (element.quantity ?? 0) + 1;
          }
        });
        await userRepository.updateInformationUser(
          UserModel(uuid: event.userId, myCarts: products),
        );
        emit(
          state.copyWith(
            myCarts: products,
            cartInsertStatus: CartQuantityStatus.insertSuccess,
          ),
        );
      } else {
        List<ProductModel> products = [
          ...state.myCarts,
          event.product.copyWith(quantity: 1)
        ];
        await userRepository.updateInformationUser(
          UserModel(uuid: event.userId, myCarts: products),
        );
        emit(
          state.copyWith(
            myCarts: products,
            cartInsertStatus: CartQuantityStatus.insertSuccess,
          ),
        );
      }
    } on SocketException catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.insertFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.insertFailure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onPlusProduct(
      CartIncrementPressed event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      cartInsertStatus: CartQuantityStatus.incrementLoading,
    ));
    try {
      final products = state.myCarts.map((element) {
        if (element.uuid == event.product.uuid &&
            element.imagePath == event.product.imagePath) {
          element = element.copyWith(
            quantity: (element.quantity ?? 0) + 1,
          );
        }
        return element;
      }).toList();
      await userRepository.updateInformationUser(
        UserModel(uuid: event.userId, myCarts: products),
      );
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.incrementSuccess,
        myCarts: products,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.incrementFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.incrementFailure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onLessProduct(
      CartDecrementPressed event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      cartInsertStatus: CartQuantityStatus.decrementLoading,
    ));
    try {
      List<ProductModel> products = state.myCarts.map((e) {
        if (e.uuid == event.product.uuid &&
            e.imagePath == event.product.imagePath) {
          e = e.copyWith(
            quantity: (e.quantity ?? 0) - 1,
          );
          if (e.quantity == 0) {
            emit(state.copyWith(
              cartInsertStatus: CartQuantityStatus.decrementFailure,
            ));
          }
        }
        return e;
      }).toList();
      products = products.where((e) => (e.quantity ?? 0) > 0).toList();
      await userRepository.updateInformationUser(
        UserModel(uuid: event.userId, myCarts: products),
      );
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.decrementSuccess,
        myCarts: products,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.decrementFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.decrementFailure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveCart(
      CartCheckoutPressed event, Emitter<CartState> emit) async {
    emit(state.copyWith(
      cartCheckoutStatus: CartEventCheckOutStatus.checkoutLoading,
    ));
    try {
      await userRepository.updateInformationUser(
        UserModel(uuid: event.userId, myCarts: const []),
      );
      emit(state.copyWith(
        myCarts: [],
        cartCheckoutStatus: CartEventCheckOutStatus.checkoutSuccess,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        cartCheckoutStatus: CartEventCheckOutStatus.checkoutFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        cartCheckoutStatus: CartEventCheckOutStatus.checkoutFailure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveProduct(
      CartRemovePressed event, Emitter<CartState> emit) async {
    emit(state.copyWith(cartInsertStatus: CartQuantityStatus.removeLoading));
    try {
      List<ProductModel> myCarts = [...state.myCarts];
      myCarts.removeWhere((element) =>
          element.uuid == event.product.uuid &&
          element.imagePath == event.product.imagePath);
      await userRepository.updateInformationUser(
        UserModel(uuid: event.userId, myCarts: myCarts),
      );
      emit(state.copyWith(
        myCarts: myCarts,
        cartInsertStatus: CartQuantityStatus.removeSuccess,
      ));
    } on SocketException catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.removeFailure,
        message: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        cartInsertStatus: CartQuantityStatus.removeFailure,
        message: e.toString(),
      ));
    }
  }
}
