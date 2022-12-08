import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class Daily extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Daily Survey',
      home: WebViewApp(),
    );
  }
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('데일리 설문조사'),
      ),
      body: InAppWebView(initialUrlRequest:
      URLRequest(url: Uri.parse("https://docs.google.com/forms/d/e/1FAIpQLSeu1jHr6rmmBVaU6xqIXmiac7Qi6J59MfgStBpkQtBkLNhF_Q/viewform?usp=sf_link"))
      ),
    );
  }
}