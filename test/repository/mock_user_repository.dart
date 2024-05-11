import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/repository/user_repository.dart';
import 'package:nike_sneaker_store/services/remote/api_client.dart';

import '../services/mock_api_client.dart';
import '../utils/mock_data.dart';

class MockUserRepository extends Fake implements UserRepository {
  @override
  ApiClient get apiClient => MockApiClient();

  @override
  Future<void> updateInformationUser(UserModel user) async {
    if ((user.uuid ?? '').isNotEmpty) {
      return;
    } else {
      throw Exception('An error occurred, please check UserId');
    }
  }

  @override
  Future<String?> uploadAvatar(File? file) async {
    return '';
  }

  @override
  Future<UserModel?> getUser({required String userId}) async {
    if (userId.isNotEmpty) {
      return MockData.mockUser;
    } else {
      throw Exception('An error occurred, please check UserId');
    }
  }
}
