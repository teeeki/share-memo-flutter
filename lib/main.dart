import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_memo_flutter/pages/memo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Memo',
      theme:
          ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.purple[50],
          ).copyWith(
            textTheme: GoogleFonts.latoTextTheme(),
          ), //GoogleFonts.lato を上書き
      home: const MemoListPage(),
    );
  }
}
