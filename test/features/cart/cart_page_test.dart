import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/components/button/ns_elevated_button.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/cart/view/cart_page.dart';
import 'package:nike_sneaker_store/features/cart/view/widgets/card_cart_product.dart';
import 'package:nike_sneaker_store/resources/ns_color.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

import '../../utils/mock_supabase.dart';
import '../../utils/ns_pump_widget.dart';

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

void main() {
  late CartBloc cartBloc;
  late Widget cartPage;

  setUp(() {
    cartBloc = MockCartBloc();
    cartPage = NsPumpWidget(
        home: MultiRepositoryProvider(
      providers: [
        BlocProvider<CartBloc>(create: (context) => cartBloc),
        RepositoryProvider<SupabaseServices>(
          create: (context) => SupabaseServices(supabaseClient: MockSupabase()),
        )
      ],
      child: const CartPage(),
    ));
  });

  group('Cart Page Test', () {
    testWidgets(
        'GIVEN the user is signed in '
        'WHEN there is no product in my cart '
        'THEN displays text that there are no products in my cart',
        (tester) async {
      // GIVEN
      when(() => cartBloc.state).thenReturn(
        const CartState(), // myCarts = []
      );

      // WHEN
      await tester.pumpWidget(cartPage);

      // THEN
      expect(find.byType(CardCartProduct), findsNothing);
      expect(
          find.text('There are no products in the cart yet'), findsOneWidget);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN there is no product in my cart '
        'THEN disable button', (tester) async {

      // GIVEN
      when(() => cartBloc.state).thenReturn(
        const CartState(), // myCarts = []
      );

      // WHEN
      await tester.pumpWidget(cartPage);

      // THEN
      final button = tester
          .widget<NSElevatedButton>(find.byType(NSElevatedButton));
      expect(button.onPressed, isNull);
      expect(button.backgroundColor, NSColor.neutral);
    });
  });
}
