import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<dynamic> memos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMemos();
  }

  Future<void> fetchMemos() async {
    const apiUrl = 'http://10.0.2.2:8000/memos'; // FastAPIのURL

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          memos = data['memos'];
          isLoading = false;
        });
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メモ一覧')),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // ローディング中はローディングインジケーターを表示
          : ListView.builder(
              // ローディング済みはメモ一覧を表示
              itemCount: memos.length,
              itemBuilder: (context, index) {
                final memo = memos[index];
                return ListTile(
                  title: Text(memo['title']),
                  subtitle: Text(memo['content']),
                );
              },
            ),
    );
  }
}
