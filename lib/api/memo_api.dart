import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:share_memo_flutter/models/memo_model.dart';

class MemoApi {
  // エンドポイント後で変更
  static const String baseUrl = 'http://10.0.2.2:8000/api/memo/';

  // メモ一覧の取得（GET: /api/memo）
  Future<List<dynamic>> getMemos() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load memos');
    }
  }

  // メモの新規作成（POST: /api/memo）
  Future<MemoModel> createMemo(Map<String, dynamic> json) async {
    final response = await http.post(
      Uri.parse('$baseUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(json),
    );

    if (response.statusCode == 200) {
      return MemoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create memo');
    }
  }
}
