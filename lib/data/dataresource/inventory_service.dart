import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/barang_model.dart';

class BarangService {
  final String baseUrl = 'http://192.168.1.66:8000/api';

  Future<List<BarangModel>> getBarang() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/barang'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => BarangModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil barang: ${response.body}');
      }
    } catch (e) {
      throw Exception('Gagal mengambil barang: $e');
    }
  }
}
