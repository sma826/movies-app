import 'dart:developer';

import 'package:movies/Auth/register/data/data%20source/register_api_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterRepository {
  final RegisterApiDataSource apiDataSource;

  RegisterRepository(this.apiDataSource);

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    final data = await apiDataSource.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
      avatarId: avatarId,
    );
    log('API Response : $data');

    if (data["statusCode"] == 201 && data["data"] != null) {
      final sharedData = await SharedPreferences.getInstance();
      final user = data["data"];

      await sharedData.setString("name", user["name"]);
      await sharedData.setString("email", user["email"]);
      await sharedData.setString("phone", user["phone"]);
      await sharedData.setString("avatarId", user["avaterId"].toString());

      log("✅ Saved user data: $user");
      return data;
    } else {
      log("❌ Register failed: ${data["message"]}");
      throw Exception(data["message"] ?? "Registration failed");
    }
  }

  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "token": prefs.getString("token"),
      "name": prefs.getString("name"),
      "email": prefs.getString("email"),
      "phone": prefs.getString("phone"),
      "avatarId": prefs.getString("avatarId"),
    };
  }
}
