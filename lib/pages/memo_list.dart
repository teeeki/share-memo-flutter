import 'package:flutter/material.dart';
import 'package:share_memo_flutter/models/memo_model.dart';
import 'package:share_memo_flutter/pages/memo_detail.dart';
import 'package:share_memo_flutter/repository/echo_repository.dart';
import 'package:share_memo_flutter/repository/memo_repository.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  // リポジトリのインスタンス化
  final EchoRepository echoRepository = EchoRepository();
  final MemoRepository memoRepository = MemoRepository();

  List<MemoModel> memos = [];

  @override
  void initState() {
    super.initState();
    createMemos();
  }

  Future<void> createMemos() async {
    final MemoModel sampleData = MemoModel(
      title: "サンプルメモ",
      user: "test_user",
      summary: "これはサンプルメモの概要です。",
      content: "これはサンプルメモの内容です。",
    );

    try {
      final MemoModel memo = await memoRepository.createMemo(sampleData);
      debugPrint('メモの作成に成功しました');
      debugPrint('作成されたメモ: ${memo.title}');
      debugPrint('ユーザ: ${memo.user}');
      debugPrint('概要: ${memo.summary}');
      setState(() {
        memos.add(memo);
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hoge')),
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
          createMemos();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMemoCard(MemoModel memo) {
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
                child: Text(
                  '${memo.title}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                ),
              ),

              // ユーザ名
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '${memo.user}',
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
                  children: [
                    Icon(Icons.description, size: 16, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      '${memo.summary}',
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
