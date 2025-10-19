import 'package:flutter/material.dart';
import 'package:share_memo_flutter/pages/memo_detail.dart';
import 'package:share_memo_flutter/repository/echo_repository.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  final EchoRepository echoRepository = EchoRepository();
  String responseText = "まだ何も送っていません";

  // サンプルデータを作成（7件）
  final List<Map<String, String>> memos = List.generate(7, (i) {
    return {
      'title': 'メモのタイトル ${i + 1}',
      'user': 'ユーザ${i + 1}',
      'summary': 'これはメモ${i + 1}の概要です。サンプルテキスト。',
    };
  });

  @override
  void initState() {
    super.initState();
    // fetchMemos();
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
        });
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        responseText = "エラー: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メモ一覧')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: memos.length,
          itemBuilder: (context, index) {
            return _buildMemoCard(memos[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 新規メモ作成ボタンの処理
          fetchMemos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMemoCard(Map<String, String> memo) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          // カードをタップで詳細ページへ遷移
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MemoDetailPage()),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer, // 画像を丸角にする
          child: Column(
            mainAxisSize: MainAxisSize.min, // Columnの高さを子要素に合わせて最小化
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // タイトル
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: const Text(
                  'メモのタイトル',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
              ),

              // ユーザ名
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.person, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'ユーザ名',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),

              // 概要
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.description, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'メモの概要',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
