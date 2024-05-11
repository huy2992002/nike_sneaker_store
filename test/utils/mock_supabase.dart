import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabase extends Fake implements SupabaseClient {
  @override
  MockGoTrue get auth => MockGoTrue();
}

class MockGoTrue extends Fake implements GoTrueClient {
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
  Future<AuthResponse> signInWithPassword({
    required String password,
    String? email,
    String? phone,
    String? captchaToken,
  }) async {
    if (email != null && email == _user.email) {
      return AuthResponse(
        session: Session(
          accessToken: '',
          tokenType: '',
          user: _user,
        ),
        user: _user,
      );
    } else {
      throw Exception('Invalid login credentials');
    }
  }

  @override
  Future<AuthResponse> signUp({
    required String password,
    String? email,
    String? phone,
    String? emailRedirectTo,
    Map<String, dynamic>? data,
    String? captchaToken,
    OtpChannel channel = OtpChannel.sms,
  }) async {
    if (email != _user.email) {
      return AuthResponse(
        user: _user,
      );
    } else {
      throw Exception('User already exists');
    }
  }

  @override
  User? get currentUser => _user;
}
