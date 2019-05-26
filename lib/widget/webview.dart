import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false,
  });

  @override
  State<StatefulWidget> createState() => _WebView();
}

class _WebView extends State<WebView> {
  final webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _webViewUrlChange;
  StreamSubscription<WebViewStateChanged> _webViewStateChange;
  StreamSubscription<WebViewHttpError> _webViewHttpError;
  bool exiting = false;

  @override
  void initState() {
    webViewReference.close();

    _webViewUrlChange = webViewReference.onUrlChanged.listen((String url) {});

    _webViewStateChange =
        webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webViewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
      }
    });

    _webViewHttpError =
        webViewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
      print(error.code);
      print(error.url);
    });
    super.initState();
  }

  @override
  void dispose() {
    _webViewUrlChange.cancel();
    _webViewStateChange.cancel();
    _webViewHttpError.cancel();
    webViewReference.dispose();
    super.dispose();
  }

  bool _isToMain(String url) {
    bool contain = false;
    for(final value in CATCH_URLS) {
      if(url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(child: Text('Waiting...')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
