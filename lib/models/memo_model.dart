// Memoエンティティクラス
class MemoModel {
  final String title;
  final String user;
  final String summary;
  final String content;

  MemoModel({
    required this.title,
    required this.user,
    required this.summary,
    required this.content,
  });

  // JSON to Userモデル
  factory MemoModel.fromJson(Map<String, dynamic> json) {
    return MemoModel(
      title: json['title'] as String,
      user: json['user'] as String,
      summary: json['summary'] as String,
      content: json['content'] as String,
    );
  }

  // Userモデル to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'user': user,
      'summary': summary,
      'content': content,
    };
  }
}
