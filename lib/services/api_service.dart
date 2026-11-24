import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/darurat_model.dart';
import '../models/obat_model.dart';

/// Service untuk menangani panggilan REST API SiagaP3K.
class ApiService {
  // Base URL server REST API
  static const String baseUrl = 'https://siagap3k-api.vercel.app';

  /// Mengambil daftar panduan darurat dari endpoint GET /darurat
  Future<List<DaruratModel>> fetchDarurat() async {
    final url = Uri.parse('$baseUrl/darurat');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic decodedJson = json.decode(response.body);

        // API mengembalikan objek { "data": [...] } atau array langsung [...]
        List<dynamic> listJson;
        if (decodedJson is Map<String, dynamic> && decodedJson.containsKey('data')) {
          listJson = decodedJson['data'] as List<dynamic>;
        } else if (decodedJson is List<dynamic>) {
          listJson = decodedJson;
        } else {
          listJson = [];
        }

        return listJson
            .map((item) => DaruratModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Gagal memuat data darurat (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data darurat: $e');
    }
  }

  /// Mengambil daftar obat & alat P3K dari endpoint GET /obat
  Future<List<ObatModel>> fetchObat() async {
    final url = Uri.parse('$baseUrl/obat');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic decodedJson = json.decode(response.body);

        // API mengembalikan objek { "data": [...] } atau array langsung [...]
        List<dynamic> listJson;
        if (decodedJson is Map<String, dynamic> && decodedJson.containsKey('data')) {
          listJson = decodedJson['data'] as List<dynamic>;
        } else if (decodedJson is List<dynamic>) {
          listJson = decodedJson;
        } else {
          listJson = [];
        }

        return listJson
            .map((item) => ObatModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
            'Gagal memuat data obat (Status Code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memuat data obat: $e');
    }
  }
}
