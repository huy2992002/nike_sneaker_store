import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

enum DetailViewStatus {
  initial,
  changeColorLoading,
  changeColorSuccess,
  changeColorFailure,
}

class DetailState extends Equatable {
  const DetailState(
      {this.productDisplay, this.status = DetailViewStatus.initial});

  final ProductModel? productDisplay;
  final DetailViewStatus status;

  DetailState copyWith({
    ProductModel? productDisplay,
    DetailViewStatus? status,
  }) {
    return DetailState(
      productDisplay: productDisplay ?? this.productDisplay,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [productDisplay, status];
}
