import 'package:nike_sneaker_store/constants/ns_constants.dart';
import 'package:nike_sneaker_store/models/user_model.dart';
import 'package:nike_sneaker_store/services/local/shared_pref_services.dart';
import 'package:nike_sneaker_store/services/remote/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthRepository({
    required this.supabaseServices,
    required this.sharedPrefServices,
  });

  final SupabaseServices supabaseServices;
  final SharedPrefServices sharedPrefServices;

  Future<User> signIn({required String email, required String password}) async {
    try {
      final authResponse =
          await supabaseServices.supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      String? accessToken = authResponse.session?.accessToken;
      String? refreshToken = authResponse.session?.refreshToken;
      if (accessToken != null && refreshToken != null) {
        sharedPrefServices
          ..saveAccessToken(accessToken)
          ..saveRefreshToken(refreshToken);
      }
      if (authResponse.user != null) {
        return authResponse.user!;
      } else {
        throw const AuthException('Dont find User', statusCode: '400');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await supabaseServices.supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'email': email},
      );
      if (authResponse.user != null) {
        if ((authResponse.user?.identities?.length ?? 0) > 0) {
          UserModel user = UserModel(
            uuid: authResponse.user?.id,
            name: name,
            email: email,
          );
          await supabaseServices.supabaseClient
              .from(NSConstants.endPointUsers)
              .insert(user.toJson());
          return authResponse.user!;
        } else {
          throw const AuthException(
            'User already registered',
            statusCode: '400',
          );
        }
      } else {
        throw const AuthException('Dont find User');
      }
    } catch (e) {
      rethrow;
    }
  }
}
