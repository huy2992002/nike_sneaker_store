import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/components/app_bar/action_icon_app_bar.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/favorite/view/favorite_page.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

import '../../utils/mock_data.dart';
import '../../utils/mock_supabase.dart';
import '../../utils/ns_pump_widget.dart';
import '../home/home_page_test.dart';

void main() {
  late HomeBloc homeBloc;
  late CartBloc cartBloc;
  late Widget favoritePage;

  setUp(() {
    homeBloc = MockHomeBloc();
    cartBloc = MockCartBloc();
    favoritePage = NsPumpWidget(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(create: (context) => homeBloc),
          BlocProvider<CartBloc>(create: (context) => cartBloc),
          RepositoryProvider<SupabaseServices>(
            create: (context) =>
                SupabaseServices(supabaseClient: MockSupabase()),
          )
        ],
        child: const FavoritePage(),
      ),
    );
  });

  group('Favorite Page Test', () {
    testWidgets(
        'GIVEN the user is signed in '
        'WHEN there is no favorite product yet '
        'THEN displays text that there are no favorite products',
        (tester) async {
      // GIVEN
      when(() => homeBloc.state).thenReturn(
        const HomeState(homeStatus: HomeViewStatus.success),
      );
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(favoritePage);

      // THEN
      expect(find.byType(CardProduct), findsNothing);
      expect(find.text('Currently there are no favorite products'),
          findsOneWidget);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN already have a favorite product '
        'THEN display list of favorite products', (tester) async {
      // GIVEN
      when(() => homeBloc.state).thenReturn(
        HomeState(
          homeStatus: HomeViewStatus.success,
          products: [MockData.mockProduct],
        ),
      );
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(favoritePage);

      // THEN
      expect(find.byType(CardProduct), findsOneWidget);
      expect(
        find.text('Currently there are no favorite products'),
        findsNothing,
      );
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN there are no products in the cart '
        'THEN show no products in cart', (tester) async {
      // GIVEN
      when(() => homeBloc.state)
          .thenReturn(const HomeState(homeStatus: HomeViewStatus.success));
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(favoritePage);

      // THEN
      final appBar =
          tester.widget<ActionIconAppBar>(find.byType(ActionIconAppBar));
      expect(appBar.isMarked, false);
    });
  });
}
