import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_bloc.dart';
import 'package:nike_sneaker_store/features/cart/bloc/cart_state.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_bloc.dart';
import 'package:nike_sneaker_store/features/home/bloc/home_state.dart';
import 'package:nike_sneaker_store/features/home/view/widgets/card_product.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_bloc.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_event.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_state.dart';
import 'package:nike_sneaker_store/features/search/view/search_page.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';

import '../../utils/mock_data.dart';
import '../../utils/mock_supabase.dart';
import '../../utils/ns_pump_widget.dart';
import '../home/home_page_test.dart';

class MockSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late SearchBloc searchBloc;
  late HomeBloc homeBloc;
  late CartBloc cartBloc;
  late Widget searchPage;

  group('Search Page Test', () {
    searchBloc = MockSearchBloc();
    homeBloc = MockHomeBloc();
    cartBloc = MockCartBloc();
    searchPage = NsPumpWidget(
        home: MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SupabaseServices>(
          create: (context) => SupabaseServices(supabaseClient: MockSupabase()),
        ),
        BlocProvider<SearchBloc>(create: (context) => searchBloc),
        BlocProvider<HomeBloc>(create: (context) => homeBloc),
        BlocProvider<CartBloc>(create: (context) => cartBloc),
      ],
      child: const SearchPage(),
    ));

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN user does not enter anything '
        'THEN display message search product', (tester) async {
      // GIVEN
      when(() => searchBloc.state).thenReturn(const SearchState());
      when(() => homeBloc.state).thenReturn(const HomeState());
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(searchPage);

      // THEN
      expect(find.text('Search product'), findsOneWidget);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN user waiting for results from the client '
        'THEN show waiting UI', (tester) async {
      // GIVEN
      when(() => searchBloc.state)
          .thenReturn(const SearchState(status: SearchViewStatus.loading));
      when(() => homeBloc.state).thenReturn(const HomeState());
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(searchPage);

      // THEN
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(CardProduct), findsNothing);
    });

    testWidgets(
        'GIVEN the user is signed in '
        'WHEN user search product '
        'THEN displays the list of found products', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 1920);
      // GIVEN
      when(() => searchBloc.state).thenReturn(SearchState(
        searchProducts: MockData.mockProducts,
      ));
      when(() => homeBloc.state).thenReturn(const HomeState());
      when(() => cartBloc.state).thenReturn(const CartState());

      // WHEN
      await tester.pumpWidget(searchPage);

      // THEN
      expect(find.text('Search product'), findsNothing);
      expect(find.byType(CardProduct), findsOneWidget);
    });
  });
}
