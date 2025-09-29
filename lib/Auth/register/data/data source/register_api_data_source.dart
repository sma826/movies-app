import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:movies/shared/constants/api_constants.dart';

class RegisterApiDataSource {
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    final response = await http.post(
      Uri.parse("${APIConstants.authBaseURL}${APIConstants.registerEndpoint}"),
      headers: {"Content-type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avatarId,
      }),
    );
    final data = jsonDecode(response.body);
    log("📌 Status Code: ${response.statusCode}");
    log("📌 Body: $data");

    if (response.statusCode == 201) {
      return {
        'statusCode': response.statusCode,
        'data': data['data'],
        'message': data['message'],
      };
    } else {
      return {
        "statusCode": response.statusCode,
        "message": data["message"] ?? "Registration failed",
      };
    }
  }
}
