import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/notification_model.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

class UserModel extends Equatable {
  /// Object user
  ///
  /// include
  /// [uuid], [name], [email] arguments must not be null
  /// and [avatar], [address], [phone] argument must be null
  UserModel({
    this.uuid,
    this.name,
    this.email,
    this.avatar,
    this.address,
    this.phone,
    this.favorites,
    this.myCarts,
    this.notifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (avatar != null) 'avatar': avatar,
      if (phone != null) 'phone': phone,
      if (favorites != null) 'favorites': favorites,
      if (myCarts != null) 'myCarts': myCarts,
      if (notifications != null) 'notifications': notifications,
    };
  }

  /// uuid of [UserModel] , argument must not be duplicated
  String? uuid;

  /// name of user
  String? name;

  /// email of user
  String? email;

  /// avatar of user
  String? avatar;

  /// address of user
  String? address;

  /// number phone of user
  String? phone;

  List<String>? favorites;

  List<ProductModel>? myCarts;

  List<NotificationModel>? notifications;

  @override
  List<Object?> get props => [
        uuid,
        name,
        email,
        avatar,
        address,
        phone,
        favorites,
        myCarts,
        notifications
      ];
}
