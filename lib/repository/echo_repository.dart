import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class EchoRepository {
  final String apiUrl = 'http://10.0.2.2:8000/api/echo';

  Future<http.Response> sendJson(Map<String, dynamic> json) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(json),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to send JSON data');
    }
  }
}
