import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/barang_model.dart';

class InventoryService {
  final String baseUrl = 'http://192.168.8.167:8000/api';

  Future<List<BarangModel>> getInventory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse('$baseUrl/barang'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => BarangModel.fromMap(json)).toList();
      } else {
        throw Exception('Gagal mengambil barang: ${response.body}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil barang: $e');
    }
  }

// lib/data/dataresource/inventory_service.dart

  Future<void> addInventory(Map<String, dynamic> data, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/barang'), // pastikan pakai /barang bukan /inventori
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'name': data['nama_barang'],
        'quantity': data['jumlah'].toString(),
        'price': data['harga'].toString(),
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Gagal menambahkan inventory: ${response.body}');
    }
  }
 // Ganti sesuai base URL kamu

  Future<void> updateInventory({
  required int id,
  required String name,
  required String price,
  required int quantity,
}) async {
  // Ambil token dulu dari SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  final url = Uri.parse('$baseUrl/barang/$id'); // pastikan pakai endpoint yang benar ya

  final response = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'name': name,
      'price': price,
      'quantity': quantity,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal update barang: ${response.body}');
  }
}

Future<void> deleteBarang(int id, String token) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/barang/$id'),
    headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Gagal menghapus barang');
  }
}




}


