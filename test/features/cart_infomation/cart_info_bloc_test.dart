import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_bloc.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_event.dart';
import 'package:nike_sneaker_store/features/cart_information/bloc/cart_info_state.dart';

void main() {
  late CartInfoBloc cartInfoBloc;

  setUp(() {
    cartInfoBloc = CartInfoBloc();
  });

  group('Cart Information Bloc Test', () {
    test('initial state is Cart Information Bloc', () {
      expect(cartInfoBloc.state, equals(const CartInfoState()));
    });

    blocTest(
      'emit display information user when started',
      build: () => cartInfoBloc,
      act: (bloc) {
        bloc.add(
          CartInfoStarted(
            email: 'email@gmail.com',
            phoneNumber: '0321654987',
            address: 'address',
          ),
        );
      },
      expect: () => [
        const CartInfoState(
            email: 'email@gmail.com',
            phoneNumber: '0321654987',
            address: 'address',
            canAction: true),
      ],
    );

    blocTest(
      'emit new email when email changed',
      build: () => cartInfoBloc,
      seed: () => const CartInfoState(
        email: 'email@gmail.com ',
        phoneNumber: '0321654987',
        address: 'address',
      ),
      act: (bloc) {
        bloc.add(CartInfoEmailChanged(email: 'new@gmail.com'));
      },
      expect: () => [
        const CartInfoState(
            email: 'new@gmail.com',
            phoneNumber: '0321654987',
            address: 'address',
            canAction: true),
      ],
    );

    blocTest(
      'emit new address when address changed',
      build: () => cartInfoBloc,
      seed: () => const CartInfoState(
        address: 'address',
      ),
      act: (bloc) {
        bloc.add(CartInfoAddressChanged(address: 'da nang'));
      },
      expect: () => [
        const CartInfoState(
          address: 'da nang',
        ),
      ],
    );

    blocTest(
      'emit new phone when phoneNumber changed',
      build: () => cartInfoBloc,
      seed: () => const CartInfoState(
        phoneNumber: '0123456789',
      ),
      act: (bloc) {
        bloc.add(CartInfoPhoneChanged(phoneNumber: '0789456123'));
      },
      expect: () => [
        const CartInfoState(
          phoneNumber: '0789456123',
        ),
      ],
    );
  });
}
