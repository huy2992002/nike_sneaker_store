import 'package:flutter_test/flutter_test.dart';
import 'package:gotrue/src/types/user.dart';
import 'package:nike_sneaker_store/repository/auth_repository.dart';

class MockAuthRepository extends Fake implements AuthRepository {
  final _user = User(
    id: 'id',
    appMetadata: {},
    userMetadata: {},
    aud: 'aud',
    email: 'testSignIn@gmail.com',
    identities: <UserIdentity>[
      const UserIdentity(
        id: 'id',
        userId: 'userId',
        identityData: {},
        identityId: 'identityId',
        provider: 'provider',
        createdAt: 'createdAt',
        lastSignInAt: 'lastSignInAt',
      ),
    ],
    createdAt: DateTime.now().toIso8601String(),
  );

  @override
  Future<User> signIn({required String email, required String password}) async {
    if (email == _user.email) {
      return _user;
    } else {
      throw Exception('Invalid login credentials');
    }
  }

  @override
  Future<User> signUp(
      {required String name,
      required String email,
      required String password}) async {
    if (email != _user.email) {
      return _user;
    } else {
      throw Exception('User already exists');
    }
  }
}
