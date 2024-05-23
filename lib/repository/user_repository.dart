import 'dart:io';
import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/services/remote/api_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  UserRepository({
    required this.apiClient,
  });

  final ApiClient apiClient;

  Future<void> updateInformationUser(UserModel user) async {
    try {
      final url = '${NSConstants.endPointUsers}?uuid=eq.${user.uuid}';
      apiClient.patch(url, data: user.toJson());
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
      String url = '${NSConstants.endPointUsers}?uuid=eq.$userId';
      final response = await apiClient.get(url);
      final data = response.data as List<dynamic>;
      if (data.isNotEmpty && data.first is Map<String, dynamic>) {
        return UserModel.fromJson(data.first as Map<String, dynamic>);
      } else {
        throw const AuthException('User not found');
      }
    } catch (e) {
      rethrow;
    }
  }
}
