// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  // const WebView({});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late InAppWebViewController inAppWebViewController;
  // WebUri webUrl = WebUri.uri(UriData.fromString('http://127.0.0.1:5500/SpotifyWebAuth/SpotifyWebAPI/index.html').uri);
  double _progress=0;
  int _stackIndex = 1;
  @override
  Widget build(BuildContext context) {
    return 
    // PopScope(
    //   onPopInvoked:(_)async{
    //     var isLastPage = await inAppWebViewController.canGoBack();
    //     if(isLastPage){
    //       inAppWebViewController.goBack();
    //       return;
    //     }
    //     return;
    //   }, 
    // child:
    
    
    SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Expanded(
          child: IndexedStack(
            index: _stackIndex,
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri('https://webauthspotify.web.app')),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform:
                      InAppWebViewOptions(useShouldOverrideUrlLoading: true),
                ),
                onLoadStop: (_, __) {
                  setState(() {
                    _stackIndex = 0;
                  });
                },
                onLoadError: (_, __, ___, ____) {
                  setState(() {
                    _stackIndex = 0;
                  });
                  //TODO: Show error alert message (Error in receive data from server)
                },
                onLoadHttpError: (_, __, ___, ____) {
                  setState(() {
                    _stackIndex = 0;
                  });
                  //TODO: Show error alert message (Error in receive data from server)
                },
              ),
              const SizedBox(
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    ),
    // ),
    );
  }
}