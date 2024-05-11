import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_event.dart';
import 'package:nike_sneaker_store/features/detail/bloc/detail_state.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState()) {
    on<DetailSelectStarted>(_onSelectProduct);
    on<DetailChangeProductPressed>(_onChangeProduct);
    on<DetailFavoritePressed>(_onFavorite);
  }

  Future<void> _onSelectProduct(
    DetailSelectStarted event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(
      productDisplay: event.product,
    ));
  }

  Future<void> _onChangeProduct(
    DetailChangeProductPressed event,
    Emitter<DetailState> emit,
  ) async {
    emit(state.copyWith(status: DetailViewStatus.changeColorLoading));
    final product = state.productDisplay;
    product?.imagePath = event.productImage;
    emit(state.copyWith(
        productDisplay: product, status: DetailViewStatus.changeColorSuccess));
  }

  Future<void> _onFavorite(
    DetailFavoritePressed event,
    Emitter<DetailState> emit,
  ) async {
    ProductModel? product = state.productDisplay?.copyWith(
      isFavorite: !(state.productDisplay?.isFavorite ?? false),
    );
    emit(state.copyWith(productDisplay: product));
  }
}
