// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewExample extends StatelessWidget {
//   WebViewExample({Key? key, this.expectedUrl=''}) : super(key: key);
//
//   final String expectedUrl='kkk';
//   // Create a webview controller
//   final _controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {
//           // print the loading progress to the console
//           // you can use this value to show a progress bar if you want
//           debugPrint("Loading: $progress%");
//         },
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse(expectedUrl));
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' Seliem Webview Example'),
//       ),
//       body: SizedBox(
//           width: double.infinity,
//           // the most important part of this example
//           child: WebViewWidget(
//             controller: _controller,
//           )),
//     );
//   }
// }