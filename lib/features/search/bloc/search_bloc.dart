import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_event.dart';
import 'package:nike_sneaker_store/features/search/bloc/search_state.dart';
import 'package:nike_sneaker_store/repository/product_repository.dart';
import 'package:nike_sneaker_store/services/handle_error/error_extension.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.productRepository}) : super(const SearchState()) {
    on<SearchTextChanged>(_onSearch);
    on<RemoveTextPressed>(_onRemoveSearchText);
  }

  ProductRepository productRepository;

  Future<void> _onSearch(
      SearchTextChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: SearchViewStatus.loading));
    try {
      if (event.searchText.isEmpty) {
        emit(state.copyWith(
          searchProducts: [],
          status: SearchViewStatus.success,
        ));
      } else {
        final products =
            await productRepository.fetchProductsByName(event.searchText);

        emit(
          state.copyWith(
            status: SearchViewStatus.success,
            searchProducts: products,
          ),
        );
      }
    } on SocketException catch (e) {
      emit(state.copyWith(
        status: SearchViewStatus.failure,
        errorMessage: e.getFailure().message,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchViewStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveSearchText(
      RemoveTextPressed event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      searchProducts: [],
    ));
  }
}
