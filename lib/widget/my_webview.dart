import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
];

class MyWebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const MyWebView({
    Key key,
    this.url,
    this.statusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWebView();
}

class _MyWebView extends State<MyWebView> {
  final FlutterWebviewPlugin webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _webViewUrlChange;
  StreamSubscription<WebViewStateChanged> _webViewStateChange;
  StreamSubscription<WebViewHttpError> _webViewHttpError;
  num maxWidth;
  // bool exiting = false;

  @override
  void initState() {
    print('my webview init');
    webViewReference.close();
    _webViewUrlChange = webViewReference.onUrlChanged.listen((String url) {});
    _webViewStateChange =
        webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url)) {
            if (widget.backForbid || false) {
              webViewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              // exiting = true;
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
  void didChangeDependencies() {
    maxWidth = MediaQuery.of(context).size.width;
    print('my webview didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _webViewUrlChange.cancel();
    _webViewStateChange.cancel();
    _webViewHttpError.cancel();
    webViewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color _statusBarColor = Color(int.parse('0xff$_statusBarColorStr'));
    Color _textColor = Color(0xffffffff);
    if (_statusBarColorStr == 'ffffff') {
      _textColor = Color(0xff000000);
    }

    List<Widget> _body = [
      // Web View
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
      ),
    ];
    if (!(widget.hideAppBar ?? false)) {
      _body.insert(0, _getAppBar(_statusBarColor, _textColor));
    }

    return Scaffold(
      body: Container(
        width: maxWidth,
        color: _statusBarColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Color.fromARGB(255, 250, 250, 250),
            child: Column(
              children: _body,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getAppBar(Color _statusBarColor, Color _textColor) {
    return Container(
      color: _statusBarColor,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: _textColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(color: _textColor, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }
}
