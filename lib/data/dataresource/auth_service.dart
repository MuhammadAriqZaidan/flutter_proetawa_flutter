import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_skl_bp/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDatasource {
  Future<Either<String, LoginModel>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final loginModel = LoginModel.fromJson(response.body);

      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', loginModel.accessToken);

      return Right(loginModel);
    } else {
      final error = jsonDecode(response.body);
      String errorMessage;

      if (error['message'] is List) {
        errorMessage = (error['message'] as List).join(', ');
      } else if (error['message'] is String) {
        errorMessage = error['message'];
      } else {
        errorMessage = 'Login gagal';
      }

      return Left(errorMessage);
    }
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return false;

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      await prefs.remove('token');
      return true;
    } else {
      print('LOGOUT FAILED: ${response.body}');
      return false;
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
