import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to MyPage',
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is MyPage'),
        ),
        body: Center(
          child: Text('Hello myPage'),
        ),
      ),
    );
  }
}