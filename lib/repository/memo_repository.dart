import 'package:share_memo_flutter/api/memo_api.dart';
import 'package:share_memo_flutter/api/memo_api.dart';
import 'package:share_memo_flutter/models/memo_model.dart';

// MemoRepository: メモに関するデータ操作を行うリポジトリ
class MemoRepository {
  final MemoApi memoApi;

  MemoRepository(this.memoApi);

  // メモ一覧の取得
  Future<List<MemoModel>> getMemos() async {
    final memos = await memoApi.getMemos();
    return memos.map((json) => MemoModel.fromJson(json)).toList();
  }

  // メモの新規作成
  Future<void> createMemo(Map<String, dynamic> json) async {
    await memoApi.createMemo(json);
  }
}
