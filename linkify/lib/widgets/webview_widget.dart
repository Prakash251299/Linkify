import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MyWebView extends StatefulWidget {
  var c;
  MyWebView(this.c, {super.key});

  // }
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('WebView'),
      // ),
      body:
      WebViewWidget(controller: widget.c),
      // ],  )
    );
  }
}
