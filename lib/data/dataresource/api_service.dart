import 'dart:convert';
import 'package:flutter_skl_bp/data/models/barang_model.dart';
import 'package:flutter_skl_bp/data/models/reseller_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/distributor_model.dart';

class ApiService {
  final String baseUrl = 'http://192.168.1.66:8000/api';

  // Fungsi bantu buat dapetin token dan header
  Future<Map<String, String>> _getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    return {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<List<Distributor>> getDistributors() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/distributor'),
        headers: headers,
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

  Future<List<Reseller>> getResellers() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse('$baseUrl/reseller'),
        headers: headers,
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

Future<List<Data>> getBarang() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/barang'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      final List<dynamic> dataList = decoded['data'];
      
      return dataList.map((item) => Data.fromMap(item)).toList(); // ✅ PARSING BENAR
    } else {
      throw Exception('Gagal mengambil barang: ${response.body}');
    }
  } catch (e) {
    throw Exception('Gagal mengambil barang: $e');
  }
}


  // Tambahkan method lain sesuai kebutuhan, semua pakai _getHeaders() ya
}
