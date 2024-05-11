import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'SUPABASE_API_KEY', defaultValue: '')
  static String supabaseApiKey = _Env.supabaseApiKey;

  @EnviedField(varName: 'SUPABASE_BASE_URL', defaultValue: '')
  static String supabaseBaseUrl = _Env.supabaseBaseUrl;

  @EnviedField(varName: 'API_URL', defaultValue: '')
  static String apiUrl = _Env.apiUrl;

  @EnviedField(varName: 'UPLOAD_URL', defaultValue: '')
  static String uploadUrl = _Env.uploadUrl;
}
