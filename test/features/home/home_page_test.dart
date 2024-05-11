import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/components/app_bar/app_bar_home.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_event.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_event.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/home/view/home_page.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_category.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:nike_sneaker_store/utils/maths.dart';

import '../../utils/mock_data.dart';
import '../../utils/mock_supabase.dart';
import '../../utils/ns_pump_widget.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockCartBloc extends MockBloc<CartEvent, CartState> implements CartBloc {}

void main() {
  late HomeBloc homeBloc;
  late CartBloc cartBloc;
  late Widget homePage;

  setUp(() {
    homeBloc = MockHomeBloc();
    cartBloc = MockCartBloc();
    homePage = NsPumpWidget(
        home: MultiRepositoryProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => homeBloc),
        BlocProvider<CartBloc>(create: (context) => cartBloc),
        RepositoryProvider<SupabaseServices>(
          create: (context) => SupabaseServices(supabaseClient: MockSupabase()),
        ),
      ],
      child: const HomePage(),
    ));
  });

  group('Home Page Test', () {
    testWidgets(
        'GIVEN the user is signed in '
        'WHEN user goes to the home page '
        'THEN category is shown', (tester) async {
      // GIVEN
      when(() => homeBloc.state).thenReturn(const HomeState());
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(homePage);

      // THEN
      expect(find.byType(CardCategory), findsWidgets);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN waiting to get data from data '
        'THEN cart product loading is shown', (tester) async {
      // GIVEN
      when(() => homeBloc.state)
          .thenReturn(const HomeState(homeStatus: HomeViewStatus.loading));
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(homePage);

      // THEN
      expect(find.byType(CardProductLoading), findsWidgets);
      expect(find.byType(CardProduct), findsNothing);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN got the product from data '
        'THEN cart product is shown', (tester) async {
      // GIVEN
      when(() => homeBloc.state).thenReturn(HomeState(
        homeStatus: HomeViewStatus.success,
        products: MockData.mockProducts,
        productDisplays: MockData.mockProducts,
      ));
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(homePage);

      // THEN
      expect(find.byType(CardProductLoading), findsNothing);
      expect(find.byType(CardProduct), findsWidgets);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN there are already products in the cart '
        'THEN displays there are products in the cart', (tester) async {
      List<ProductModel> mockCarts = [
        ProductModel(uuid: Maths.randomUUid(length: 4), name: 'Product 1'),
      ];

      // GIVEN
      when(() => homeBloc.state)
          .thenReturn(const HomeState(homeStatus: HomeViewStatus.success));
      when(() => cartBloc.state).thenReturn(CartState(myCarts: mockCarts));

      // WHEN
      await tester.pumpWidget(homePage);

      // THEN
      final appBarHome = tester.widget<AppBarHome>(find.byType(AppBarHome));
      expect(appBarHome.isMarkerNotification, true);
    });
  });
}
