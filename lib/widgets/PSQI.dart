import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PSQI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to PSQI',
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
        title: const Text('최적화된 잠 설문'),
      ),
      body: InAppWebView(initialUrlRequest:
      URLRequest(url: Uri.parse("https://docs.google.com/forms/d/e/1FAIpQLSeK74OnPZRDEMiwxHROzKStUb-DQUJOa8HKbXA8X_OJIuiEhA/viewform?usp=sf_link"))
      ),
    );
  }
}