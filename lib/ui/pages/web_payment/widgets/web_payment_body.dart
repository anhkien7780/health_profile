import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:health_profile/generated/l10n.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPaymentBody extends StatefulWidget {
  final String paymentUrl;

  const WebPaymentBody({super.key, required this.paymentUrl});

  @override
  State<WebPaymentBody> createState() => _WebPaymentBodyState();
}

class _WebPaymentBodyState extends State<WebPaymentBody> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(s.securePaymentTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
