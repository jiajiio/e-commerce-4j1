import 'package:flutter/material.dart';
import 'package:java_toys/pages/pages.dart';
import 'package:java_toys/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatelessWidget {
  const WebView({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          url,
        ),
      );
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Payment',
        leading: GestureDetector(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
