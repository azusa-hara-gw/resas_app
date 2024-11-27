import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        //AppBarにconstはつけられない
        //AppBarは高さ調節とかがあるからコンパイル時に確定できない値(
        //上位にConstをつけない
        appBar: AppBar(title: const Text('市区町村一覧'),
        ),
        body: const Center(
          child: Text('市区町村の一覧画面です'),
        ),
      ),
    );
  }
}