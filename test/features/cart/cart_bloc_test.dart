import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';

import '../../repository/mock_product_repository.dart';
import '../../repository/mock_user_repository.dart';
import '../../utils/mock_data.dart';

void main() {
  late ProductRepository productRepository;
  late UserRepository userRepository;
  late CartBloc cartBloc;

  setUp(() {
    productRepository = MockProductRepository();
    userRepository = MockUserRepository();
    cartBloc = CartBloc(productRepository, userRepository);
  });

  group('Cart Bloc Test', () {
    test('initial state is Cart Bloc', () {
      expect(cartBloc.state, equals(const CartState()));
    });

    blocTest(
      'emit list product in cart ',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(CartStarted(userId: 'userId'));
      },
      expect: () => [
        const CartState(
          viewStatus: CartViewStatus.loading,
        ),
        CartState(
          myCarts: MockData.mockProducts,
          viewStatus: CartViewStatus.success,
        ),
      ],
    );

    blocTest(
      'emit message failure when fetch data failure ',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(CartStarted(userId: ''));
      },
      expect: () => [
        const CartState(
          viewStatus: CartViewStatus.loading,
        ),
        const CartState(
          message: 'Exception: An error occurred, please check UserId',
          viewStatus: CartViewStatus.failure,
        ),
      ],
    );

    blocTest(
      'emit message failure when fetch data failure ',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(CartStarted(userId: ''));
      },
      expect: () => [
        const CartState(
          viewStatus: CartViewStatus.loading,
        ),
        const CartState(
          message: 'Exception: An error occurred, please check UserId',
          viewStatus: CartViewStatus.failure,
        ),
      ],
    );

    blocTest(
      'emit product with quantity 1 to cart when add product ',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(
            CartInsertPressed(userId: 'userId', product: MockData.mockProduct));
      },
      expect: () => [
        const CartState(cartInsertStatus: CartQuantityStatus.insertLoading),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.insertSuccess,
        ),
      ],
    );

    blocTest(
      'emit increment quantity when add product already ',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 3)]),
      act: (bloc) {
        bloc.add(
            CartInsertPressed(userId: 'userId', product: MockData.mockProduct));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 4)],
          cartInsertStatus: CartQuantityStatus.insertLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 4)],
          cartInsertStatus: CartQuantityStatus.insertSuccess,
        ),
      ],
    );

    blocTest(
      'emit message when add to cart failure ',
      build: () => cartBloc,
      act: (bloc) {
        bloc.add(CartInsertPressed(userId: '', product: MockData.mockProduct));
      },
      expect: () => [
        const CartState(
          cartInsertStatus: CartQuantityStatus.insertLoading,
        ),
        const CartState(
          message: 'Exception: An error occurred, please check UserId',
          cartInsertStatus: CartQuantityStatus.insertFailure,
        ),
      ],
    );

    blocTest(
      'emit increment product when on plus ',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 2)]),
      act: (bloc) {
        bloc.add(CartIncrementPressed(
          userId: 'userId',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 2)],
          cartInsertStatus: CartQuantityStatus.incrementLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 3)],
          cartInsertStatus: CartQuantityStatus.incrementSuccess,
        ),
      ],
    );

    blocTest(
      'emit message when increment product failure ',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 2)]),
      act: (bloc) {
        bloc.add(CartIncrementPressed(
          userId: '',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 2)],
          cartInsertStatus: CartQuantityStatus.incrementLoading,
        ),
        CartState(
            myCarts: [MockData.mockProduct.copyWith(quantity: 2)],
            cartInsertStatus: CartQuantityStatus.incrementFailure,
            message: 'Exception: An error occurred, please check UserId'),
      ],
    );

    blocTest(
      'emit decrement product when on less ',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 2)]),
      act: (bloc) {
        bloc.add(CartDecrementPressed(
          userId: '12345',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 2)],
          cartInsertStatus: CartQuantityStatus.decrementLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.decrementSuccess,
        )
      ],
    );

    blocTest(
      'emit remove product when on less quantity 0 ',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 1)]),
      act: (bloc) {
        bloc.add(CartDecrementPressed(
          userId: '12345',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.decrementLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.decrementFailure,
        ),
        const CartState(
          cartInsertStatus: CartQuantityStatus.decrementSuccess,
        )
      ],
    );

    blocTest(
      'emit remove product when on less quantity 0 ',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 1)]),
      act: (bloc) {
        bloc.add(CartDecrementPressed(
          userId: '',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.decrementLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.decrementFailure,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.decrementFailure,
          message: 'Exception: An error occurred, please check UserId',
        )
      ],
    );

    blocTest(
      'emit remove all product when submit checkout',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 1)]),
      act: (bloc) {
        bloc.add(CartCheckoutPressed(userId: '12345'));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartCheckoutStatus: CartEventCheckOutStatus.checkoutLoading,
        ),
        const CartState(
          // myCarts:  [],
          cartCheckoutStatus: CartEventCheckOutStatus.checkoutSuccess,
        ),
      ],
    );

    blocTest(
      'emit message when checkout failure',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 1)]),
      act: (bloc) {
        bloc.add(CartCheckoutPressed(userId: ''));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartCheckoutStatus: CartEventCheckOutStatus.checkoutLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartCheckoutStatus: CartEventCheckOutStatus.checkoutFailure,
          message: 'Exception: An error occurred, please check UserId',
        ),
      ],
    );

    blocTest(
      'emit remove product when submit remove',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 1)]),
      act: (bloc) {
        bloc.add(CartRemovePressed(
          userId: '12345',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.removeLoading,
        ),
        const CartState(
          // myCarts:  [],
          cartInsertStatus: CartQuantityStatus.removeSuccess,
        ),
      ],
    );

    blocTest(
      'emit message when remove  product failure',
      build: () => cartBloc,
      seed: () =>
          CartState(myCarts: [MockData.mockProduct.copyWith(quantity: 1)]),
      act: (bloc) {
        bloc.add(CartRemovePressed(
          userId: '',
          product: ProductModel(uuid: '12345'),
        ));
      },
      expect: () => [
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.removeLoading,
        ),
        CartState(
          myCarts: [MockData.mockProduct.copyWith(quantity: 1)],
          cartInsertStatus: CartQuantityStatus.removeFailure,
          message: 'Exception: An error occurred, please check UserId',
        ),
      ],
    );
  });
}
