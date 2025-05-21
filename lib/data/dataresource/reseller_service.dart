import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/reseller_model.dart';

class ResellerService {
  final String baseUrl = 'http://192.168.1.66:8000/api';

  Future<List<Reseller>> getResellers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/resellers'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Reseller.fromMap(json)).toList();
      } else {
        throw Exception('Gagal mengambil reseller: ${response.body}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil reseller: $e');
    }
  }
}
