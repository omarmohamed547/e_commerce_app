import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;

  const PaymentWebViewScreen({super.key, required this.url});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late InAppWebViewController webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Payment")),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.url)),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onProgressChanged: (controller, progressValue) {
              setState(() {
                progress = progressValue / 100;
              });
            },
            onLoadStop: (controller, url) {
              if (url.toString().contains("success") ||
                  url.toString().contains("paymob.com/thank_you")) {
                // ✅ Payment Success — you can customize the condition
                Navigator.pop(context);
              }
            },
          ),
          if (progress < 1.0)
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
