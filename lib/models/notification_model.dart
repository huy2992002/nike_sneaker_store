import 'package:equatable/equatable.dart';
import 'package:nike_sneaker_store/models/product_model.dart';

class NotificationModel extends Equatable {
  /// Object notification
  ///
  /// include
  /// [uuid], [title], [product], [priceSale], [date], arguments must not be null
  /// and [isRead] argument has default value is false
  NotificationModel({
    required this.uuid,
    required this.title,
    this.product,
    this.priceSale,
    this.date,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      product: json['product'] == null
          ? null
          : ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      priceSale: double.parse(json['priceSale'].toString()),
      isRead: json['isRead'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'product': product?.toJson(),
      'priceSale': priceSale,
      'date': date,
      'isRead': isRead,
    };
  }

  NotificationModel copyWith({
    String? uuid,
    String? title,
    ProductModel? product,
    double? priceSale,
    bool? isRead,
    String? date,
  }) {
    return NotificationModel(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      product: product ?? this.product,
      priceSale: priceSale ?? this.priceSale,
      isRead: isRead ?? this.isRead,
      date: date ?? this.date,
    );
  }

  /// uuid of [NotificationModel] , argument must not be duplicated
  String uuid;

  /// Title of notification
  String title;

  /// The [product] is represents of the [NotificationModel]
  ProductModel? product;

  /// Price when product sale
  double? priceSale;

  /// Status of [NotificationModel] has been read or not
  bool isRead;

  /// The time the notification is sent
  String? date;

  @override
  List<Object?> get props => [uuid, title, product, priceSale, isRead, date];
}
