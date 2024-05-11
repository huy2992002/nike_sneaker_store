import 'package:nike_sneaker_store/models/notification_model.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/models/user_model.dart';

class MockData {
  static List<ProductModel> mockProducts = [
    ProductModel(uuid: '12345', name: 'Product 1'),
  ];

  static ProductModel mockProduct =
      ProductModel(uuid: '12345', name: 'Product 1', isFavorite: true);

  static List<NotificationModel> mockNotifications = [
    NotificationModel(
      uuid: '12345',
      title: 'Notification 1',
      product: mockProducts[0],
    )
  ];

  static UserModel mockUser = UserModel(
    uuid: '12345',
    name: 'User 1',
  );
}
