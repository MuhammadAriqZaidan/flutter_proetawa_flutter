import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/distributor_model.dart';

class DistributorService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Distributor>> getDistributors() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/distributor'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Distributor.fromMap(json)).toList();
      } else {
        throw Exception('Gagal mengambil distributor: ${response.body}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil distributor: $e');
    }
  }

Future<void> addDistributor({
  required String token,
  required String nama,
  required String noTelp,
  required String alamat,
}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/distributor'), // ganti sesuai endpoint kamu
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
    body: {
      'nama': nama,
      'no_telp': noTelp,
      'alamat': alamat,
    },
  );

  if (response.statusCode != 201) {
    print('Gagal: ${response.statusCode} => ${response.body}');
    throw Exception('Gagal menambahkan distributor: ${response.body}');
  }
}

}
