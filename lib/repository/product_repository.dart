import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/models/notification_model.dart';
import 'package:nike_sneaker_store/models/product_model.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:nike_sneaker_store/utils/maths.dart';

class ProductRepository {
  ProductRepository({
    required this.supabaseServices,
  });

  final SupabaseServices supabaseServices;

  // ProductRepository({required this.apiClient});

  // final ApiClient apiClient;

  Future<List<ProductModel>?> getProducts({int maxLength = 4}) async {
    try {
      final data = await supabaseServices.supabaseClient
          .from(NSConstants.tableProducts)
          .select()
          .range(0, maxLength);
      return data.map((e) {
        return ProductModel.fromJson(e);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>?> getIdProductFavorites(String userId) async {
    try {
      final data = await supabaseServices.supabaseClient
          .from(NSConstants.tableUsers)
          .select('favorites')
          .eq('uuid', userId);
      if (data.isEmpty) {
        throw Exception('User not found');
      } else {
        if ((data[0] as Map).containsKey('favorites')) {
          return (data[0]['favorites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList();
        } else {
          throw Exception('Dont found favorites on server');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>?> getIdProductCart(String userId) async {
    try {
      final data = await supabaseServices.supabaseClient
          .from(NSConstants.tableUsers)
          .select('myCarts')
          .eq('uuid', userId);
      if (data.isEmpty) {
        throw Exception('User not found');
      } else {
        if ((data[0] as Map).containsKey('myCarts')) {
          return (data[0]['myCarts'] as List<dynamic>?)
              ?.map((e) => e is Map<String, dynamic>
                  ? ProductModel.fromJson(e)
                  : ProductModel())
              .toList();
        } else {
          throw Exception('Dont found myCarts on server');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>?> fetchProductsByName(String name) async {
    try {
      final data = await supabaseServices.supabaseClient
          .from(NSConstants.tableProducts)
          .select()
          .ilike('name', '*$name*');
      return data.map(ProductModel.fromJson).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NotificationModel>?> fetchNotifications(String userId) async {
    try {
      final data = await supabaseServices.supabaseClient
          .from(NSConstants.tableUsers)
          .select('notifications')
          .eq('uuid', userId);
      if (data.isEmpty) {
        throw Exception('User not found');
      } else {
        if ((data[0] as Map).containsKey('notifications')) {
          return (data[0]['notifications'] as List<dynamic>?)
              ?.map(
                (e) => e is Map<String, dynamic>
                    ? NotificationModel.fromJson(e)
                    : NotificationModel(
                        uuid: Maths.randomUUid(length: 4), title: 'Title'),
              )
              .toList();
        } else {
          throw Exception('Dont found favorites on server');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<ProductModel>?> getProducts({int maxLength = 4}) async {
  //   try {
  //     final response = await apiClient.get(
  //       NSConstants.endPointProducts,
  //       options: Options(headers: {'Range': '0-$maxLength'}),
  //     );
  //     final data = response.data as List<dynamic>?;
  //     return data?.map((e) {
  //       return e is Map<String, dynamic>
  //           ? ProductModel.fromJson(e)
  //           : ProductModel();
  //     }).toList();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<String>?> getIdProductFavorites(String? userId) async {
  //   String url =
  //       '${NSConstants.endPointUsers}?uuid=eq.$userId&select=favorites';
  //   try {
  //     final response = await apiClient.get(url);
  //     final data = response.data as List<dynamic>;
  //     if (data.isEmpty) {
  //       throw Exception('User not found');
  //     } else {
  //       if (data[0] is Map && (data[0] as Map).containsKey('favorites')) {
  //         return (data[0]['favorites'] as List<dynamic>?)
  //             ?.map((e) => e as String)
  //             .toList();
  //       } else {
  //         throw Exception('Dont found favorites on server');
  //       }
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<ProductModel>?> getIdProductCart(String? userId) async {
  //   String url = '${NSConstants.endPointUsers}?uuid=eq.$userId&select=myCarts';
  //   try {
  //     final response = await apiClient.get(url);
  //     final data = response.data as List<dynamic>;
  //     if (data.isEmpty) {
  //       throw Exception('User not found');
  //     } else {
  //       if (data[0] is Map && (data[0] as Map).containsKey('myCarts')) {
  //         return (data[0]['myCarts'] as List<dynamic>?)
  //             ?.map((e) => e is Map<String, dynamic>
  //                 ? ProductModel.fromJson(e)
  //                 : ProductModel())
  //             .toList();
  //       } else {
  //         throw Exception('Dont found myCarts on server');
  //       }
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<ProductModel>?> fetchProductsByName(String name) async {
  //   try {
  //     final url = '${NSConstants.endPointProducts}?name=ilike.*$name*';
  //     final response = await apiClient.get(url);
  //     final data = response.data as List<dynamic>;
  //     return data
  //         .map((e) => e is Map<String, dynamic>
  //             ? ProductModel.fromJson(e)
  //             : ProductModel())
  //         .toList();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<List<NotificationModel>?> fetchNotifications(String? userId) async {
  //   String url =
  //       '${NSConstants.endPointUsers}?uuid=eq.$userId&select=notifications';
  //   try {
  //     final response = await apiClient.get(url);
  //     final data = response.data as List<dynamic>;
  //     if (data.isEmpty) {
  //       throw Exception('User not found');
  //     } else {
  //       if (data[0] is Map && (data[0] as Map).containsKey('notifications')) {
  //         return (data[0]['notifications'] as List<dynamic>?)
  //             ?.map(
  //               (e) => e is Map<String, dynamic>
  //                   ? NotificationModel.fromJson(e)
  //                   : NotificationModel(
  //                       uuid: Maths.randomUUid(length: 4), title: 'Title'),
  //             )
  //             .toList();
  //       } else {
  //         throw Exception('Dont found favorites on server');
  //       }
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
