import 'dart:io';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/services/remote/api_client.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  UserRepository({
    required this.supabaseServices,
    required this.apiClient,
  });

  final SupabaseServices supabaseServices;
  final ApiClient apiClient;

  Future<void> updateInformationUser(UserModel user) async {
    try {
      // final url = '${NSConstants.endPointUsers}?uuid=eq.${user.uuid}';
      // apiClient.patch(url, data: user.toJson());
      await supabaseServices.supabaseClient
          .from(NSConstants.tableUsers)
          .update(user.toJson())
          .eq('uuid', user.uuid ?? '');
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> uploadAvatar(File? file) async {
    try {
      return file == null ? null : await apiClient.uploadImage(file);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser({
    required String userId,
  }) async {
    try {
      final data = await supabaseServices.supabaseClient
          .from(NSConstants.tableUsers)
          .select()
          .eq('uuid', userId);
      if (data.isNotEmpty) {
        return UserModel.fromJson(data.first);
      } else {
        throw const AuthException('User not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}
