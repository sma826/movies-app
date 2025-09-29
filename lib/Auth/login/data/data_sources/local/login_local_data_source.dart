abstract class LoginLocalDataSource {
  Future<void> saveToken(String token);

  Future<String?> getToken();
}
