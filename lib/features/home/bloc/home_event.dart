import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class HomeStarted extends HomeEvent {
  HomeStarted({required this.userId});
  final String userId;

  @override
  List<Object?> get props => [userId];
}

class HomeLoadMore extends HomeEvent {
  HomeLoadMore({required this.userId, required this.types});
  final List<String> types;
  final String userId;
  @override
  List<Object?> get props => [types,userId];
}

class HomeCategoryPressed extends HomeEvent {
  HomeCategoryPressed({required this.index, required this.type});

  final int index;
  final String type;

  @override
  List<Object?> get props => [index, type];
}

class HomeFavoritePressed extends HomeEvent {
  HomeFavoritePressed({
    required this.userId,
    this.productId,
  });

  final String userId;
  final String? productId;

  @override
  List<Object?> get props => [userId, productId];
}

class HomeFavoriteRemove extends HomeEvent {
  HomeFavoriteRemove({
    required this.productId,
  });

  final String productId;

  @override
  List<Object?> get props => [productId];
}

class HomeUserChanged extends HomeEvent {
  HomeUserChanged({
    this.name,
    this.address,
    this.phone,
    this.avatar,
  });

  final String? name;
  final String? address;
  final String? phone;
  final String? avatar;

  @override
  List<Object?> get props => [name, address, phone, avatar];
}
