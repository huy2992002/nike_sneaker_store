import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

enum SearchViewStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.searchProducts = const [],
    this.status = SearchViewStatus.initial,
    this.errorMessage = '',
  });

  final List<ProductModel> searchProducts;
  final SearchViewStatus status;
  final String errorMessage;

  SearchState copyWith({
    List<ProductModel>? searchProducts,
    SearchViewStatus? status,
    String? errorMessage,
  }) {
    return SearchState(
      searchProducts: searchProducts ?? this.searchProducts,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        searchProducts,
        status,
        errorMessage,
      ];
}
