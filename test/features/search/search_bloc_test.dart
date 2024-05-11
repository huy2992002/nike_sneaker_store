import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_bloc.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_event.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_state.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';

import '../../repository/mock_product_repository.dart';
import '../../utils/mock_data.dart';

void main() {
  late ProductRepository productRepository;
  late SearchBloc searchBloc;

  setUp(() {
    productRepository = MockProductRepository();
    searchBloc = SearchBloc(productRepository: productRepository);
  });

  group('Search Bloc Test', () {
    test('initial state is HomeState', () {
      expect(searchBloc.state, equals(const SearchState()));
    });

    blocTest(
      'emit status loading & emit data empty when there is no search content',
      build: () => searchBloc,
      act: (bloc) {
        bloc.add(SearchTextChanged(searchText: ''));
      },
      expect: () => [
        const SearchState(status: SearchViewStatus.loading),
        const SearchState(
            status: SearchViewStatus.success), // searchProducts: []
      ],
    );

    blocTest(
      'emit status loading & emit data when search success',
      build: () => searchBloc,
      act: (bloc) {
        bloc.add(SearchTextChanged(searchText: 'searchText'));
      },
      expect: () => [
        const SearchState(status: SearchViewStatus.loading),
        SearchState(
          status: SearchViewStatus.success,
          searchProducts: MockData.mockProducts,
        ),
      ],
    );

    blocTest(
      'emit message when search failure',
      build: () => searchBloc,
      act: (bloc) {
        bloc.add(SearchTextChanged(searchText: '***'));
      },
      expect: () => [
        const SearchState(status: SearchViewStatus.loading),
        const SearchState(
          status: SearchViewStatus.failure,
          errorMessage: 'Exception: Dont find product',
        ),
      ],
    );

    blocTest(
      'emit searchProduct empty when remove searchText',
      build: () => searchBloc,
      act: (bloc) {
        bloc.add(RemoveTextPressed());
      },
      expect: () => [
        const SearchState(
            // searchProducts: []
            ),
      ],
    );
  });
}
