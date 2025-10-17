import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:share_memo_flutter/repository/echo_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Memo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MemoListPage(),
    );
  }
}

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  // あとで定義
  final EchoRepository echoRepository = EchoRepository();
  String responseText = "まだ何も送っていません";

  List<dynamic> memos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMemos();
  }

  Future<void> fetchMemos() async {
    // const apiUrl = 'http://10.0.2.2:8000/memos'; // FastAPIのURL

    final Map<String, dynamic> sampleData = {
      "user": "test_user",
      "memos": [
        {"title": "メモ1", "content": "これはメモ1の内容です。"},
        {"title": "メモ2", "content": "これはメモ2の内容です。"},
        {"title": "メモ3", "content": "これはメモ3の内容です。"},
      ],
    };

    try {
      final response = await echoRepository.sendJson(sampleData);
      print(response.body);
      if (response.statusCode == 200) {
        setState(() {
          // final responseText = jsonDecode(response.body) as Map<String, dynamic>;
          responseText = response.body;
          isLoading = false;
        });
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        isLoading = false;
        responseText = "エラー: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(title: const Text('メモ一覧')),
    //   body: isLoading
    //       ? const Center(
    //           child: CircularProgressIndicator(),
    //         ) // ローディング中はローディングインジケーターを表示
    //       : ListView.builder(
    //           // ローディング済みはメモ一覧を表示
    //           itemCount: memos.length,
    //           itemBuilder: (context, index) {
    //             final memo = memos[index];
    //             return ListTile(
    //               title: Text(memo['title']),
    //               subtitle: Text(memo['content']),
    //             );
    //           },
    //         ),
    // );

    return Scaffold(
      appBar: AppBar(title: const Text('Echo Response')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(responseText),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: fetchMemos, child: const Text('送信')),
          ],
        ),
      ),
    );
  }
}
