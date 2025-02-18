abstract class DatabaseRepo {
  bool isSignedIn();
  Future<void> signIn({required String email, required String password});
  Future<void> signUp(
      {required String name, required String email, required String password});
  Future<void> sendOtp({required String email});
  Future<void> verifyOtp({required String email, required String code});
}