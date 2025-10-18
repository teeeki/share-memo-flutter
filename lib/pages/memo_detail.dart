import 'package:flutter/material.dart';

class MemoDetailPage extends StatefulWidget {
  const MemoDetailPage({super.key});

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  List<dynamic> memos = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メモ一覧')),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer, // 画像を丸角にする
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      'assets/images/27024336_s.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ハートアイコン
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ),
                      iconSize: 28,
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(), // アイコンボタンの余白を0にするため記述
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              // タイトル
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: const Text(
                  'タイトル',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                ),
              ),
              // ユーザ名
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person, size: 18, color: Colors.grey[600]),
                      const Text(
                        'ユーザ名',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14),
              // 説明文
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'ここに説明文が入ります。ここに説明文が入ります。ここに説明文が入ります。ここに説明文が入ります。',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
