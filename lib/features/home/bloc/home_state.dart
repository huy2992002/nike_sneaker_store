import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/models/user_model.dart';

enum HomeViewStatus { initial, loading, success, failure }

enum HomeFavoriteStatus {
  favoriteInitial,
  favoriteLoading,
  favoriteSuccess,
  favoriteFailure,
}

enum HomeLoadMoreStatus {
  loadInitial,
  loading,
  loadSuccess,
  loadFailure,
  loadCompeted,
}

class HomeState extends Equatable {
  const HomeState({
    this.products = const [],
    this.productDisplays = const [],
    this.maxItem = 4,
    this.loadStatus = HomeLoadMoreStatus.loadInitial,
    this.user,
    this.categoryIndex = 0,
    this.homeStatus = HomeViewStatus.initial,
    this.favoriteStatus = HomeFavoriteStatus.favoriteInitial,
    this.errorMessage = '',
  });

  final List<ProductModel> products;
  final List<ProductModel> productDisplays;
  final int maxItem;
  final HomeLoadMoreStatus loadStatus;
  final UserModel? user;
  final int categoryIndex;
  final HomeViewStatus homeStatus;
  final HomeFavoriteStatus favoriteStatus;
  final String errorMessage;

  HomeState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? productDisplays,
    UserModel? user,
    int? maxItem,
    HomeLoadMoreStatus? loadStatus,
    HomeFavoriteStatus? favoriteStatus,
    int? categoryIndex,
    HomeViewStatus? homeStatus,
    String? errorMessage,
  }) {
    return HomeState(
      products: products ?? this.products,
      productDisplays: productDisplays ?? this.productDisplays,
      maxItem: maxItem ?? this.maxItem,
      loadStatus: loadStatus ?? this.loadStatus,
      user: user ?? this.user,
      categoryIndex: categoryIndex ?? this.categoryIndex,
      homeStatus: homeStatus ?? this.homeStatus,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        products,
        productDisplays,
        maxItem,
        loadStatus,
        favoriteStatus,
        user,
        categoryIndex,
        homeStatus,
        errorMessage,
      ];
}
