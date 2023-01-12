import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleep_ugrp/widgets/Login.dart';

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
          child: Login(),
        ),
      ),
    );
  }
}