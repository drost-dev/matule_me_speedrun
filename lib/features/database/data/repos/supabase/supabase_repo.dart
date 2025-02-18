import 'package:matule_me_speedrun/features/database/domain/repos/database_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepo extends DatabaseRepo {
  late final SupabaseClient _client;

  SupabaseRepo._init(this._client);

  static Future<SupabaseRepo> init() async {
    var sb = await Supabase.initialize(
      url: 'https://uqpmzeeszodaaklmvoxe.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxcG16ZWVzem9kYWFrbG12b3hlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzNDQ4MDAsImV4cCI6MjA1NDkyMDgwMH0.kqD92ybsgKPXqD_v19aJNY8vTjS59qQyMXDl6Xa7kKU',
    );

    var repo = SupabaseRepo._init(sb.client);

    return repo;
  }

  @override
  bool isSignedIn() {
    return _client.auth.currentUser != null;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(password: password, email: email);
  }

  @override
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    await _client.auth
        .signUp(password: password, email: email, data: {"name": name});
  }

  @override
  Future<void> sendOtp({required String email}) async {
    await _client.auth.signInWithOtp(email: email);
  }

  @override
  Future<void> verifyOtp({required String email, required String code}) async {
    await _client.auth
        .verifyOTP(email: email, token: code, type: OtpType.email);
  }
}
