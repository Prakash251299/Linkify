// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// // import 'dart:async';

// class WebViewClass extends StatefulWidget {
//   const WebViewClass({super.key});

//   @override
//   _WebViewClassState createState() => _WebViewClassState();
// }

// class _WebViewClassState extends State<WebViewClass> {
//   // Completer<WebViewController> _controller = Completer<WebViewController>();
//   final controller = WebViewController
//   ..setJavaScriptMode(JavascriptMode.disabled)
//   ..loadRequest(Uri.parse("https:www.google.com"));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WebView'),
//       ),
//       body: WebView(
//         initialUrl: 'https://www.google.com',
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MyWebView extends StatefulWidget {
  var c;
  MyWebView(this.c, {super.key});

  // }
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  // WebViewController _controller = WebViewController();

  // // void fun()async{
  // //   _controller = await _getController();

  // // }
  // // @override
  // // initState() {
  //   // fun();
  //   // print("initState Called");
  // // }

  // Future<WebViewController> _getController() async {
  //   late final PlatformWebViewControllerCreationParams params;
  //   params = WebViewPlatform.instance is WebKitWebViewPlatform
  //       ? WebKitWebViewControllerCreationParams(
  //           allowsInlineMediaPlayback: true, mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{})
  //       : const PlatformWebViewControllerCreationParams();

  //   final controller = WebViewController.fromPlatformCreationParams(
  //     params,
  //     onPermissionRequest: (request) {
  //       request.grant();
  //     },
  //   );
  //   await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  //   await controller.loadRequest(Uri.parse( "https://www.google.com" ));

  //   return controller;
  // }


  // PlatformWebViewControllerCreationParams params =
  //   const PlatformWebViewControllerCreationParams();
    

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body:
      SizedBox(),
      // body: Column(children: [
      //   InkWell(child:Container(color: Colors.blue,height: 200,width:200),
      //   onTap: ()async{_controller = await _getController();},),
      // WebViewWidget(controller: widget.c),
      // ],  )
    );
  }
}
