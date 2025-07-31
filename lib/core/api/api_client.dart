import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiClient {
  final http.Client _client = http.Client();

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? params,
  }) async {
    final uri = Uri.parse(
      '${Constants.baseUrl}$endpoint',
    ).replace(queryParameters: {'api_key': Constants.apiKey, ...?params});

    try {
      final response = await _client.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}
