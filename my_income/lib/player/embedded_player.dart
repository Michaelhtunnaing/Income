import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyEmbedded extends StatefulWidget {
  final String link;
  const MyEmbedded({super.key, required this.link});

  @override
  State<MyEmbedded> createState() => _MyEmbeddedState();
}

class _MyEmbeddedState extends State<MyEmbedded> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
         
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(
          Uri.parse('https://bnhhok.hoolights.com/embed/UEQglBdmcmkQP'))
      ..enableZoom(true)
      ..reload();
      
   

    // #enddocregion webview_controller
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HighLight')),
      body: Stack(children: [
        AspectRatio(
            aspectRatio: 16 / 9, child: WebViewWidget(controller: controller)),
      ]),
    );
  }
  // #enddocregion webview_widget
}
