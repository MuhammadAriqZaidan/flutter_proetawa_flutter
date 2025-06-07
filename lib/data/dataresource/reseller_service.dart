// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/reseller_model.dart';

class ResellerService {
  final String baseUrl = 'http://192.168.8.167:8000/api';

  Future<List<Reseller>> getResellers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/reseller'),
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

  Future<void> addReseller({
    required String token,
    required String nama,
    required String noTelp,
    required String alamat,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reseller'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nama': nama,
        'no_telp': noTelp,
        'alamat': alamat,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan reseller: ${response.body}');
    }
  }

Future<void> deleteReseller(int id, String token) async {
  final url = Uri.parse('$baseUrl/reseller/$id');
  print('DELETE ke: $url');

  try {
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Gagal menghapus reseller: ${response.body}');
    }
  } catch (e) {
    print('Error saat delete reseller: $e');
    rethrow;
  }
}




Future<void> editReseller({
  required int id,
  required String nama,
  required String noTelp,
  required String alamat,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final response = await http.put(
    Uri.parse('$baseUrl/reseller/$id'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: {
      'nama': nama,
      'no_telp': noTelp,
      'alamat': alamat,
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal mengedit reseller: ${response.body}');
  }
}

Future<void> deleteHistory(int id, String token) async {
  final String url = '$baseUrl/barang-history/$id';
  print('DELETE History ke: $url');

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Gagal menghapus history: ${response.body}');
    }
  } catch (e) {
    print('Error saat delete history: $e');
    rethrow;
  }
}


}
