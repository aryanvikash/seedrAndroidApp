import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constants.dart';

String selectedUrl = 'https://www.seedr.cc';

class CustomWebView extends StatefulWidget {
  const CustomWebView({Key? key}) : super(key: key);

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final cookieManager = WebviewCookieManager();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: selectedUrl,
              javascriptMode: JavascriptMode.unrestricted,
              userAgent: AndroidUserAgent,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              final gotCookies = await cookieManager.getCookies(selectedUrl);
              var cookie = gotCookies[1].toString();
              print(cookie);
              var box = Hive.box("seedr");

              box.put("token", cookie.toString());
              Navigator.pushNamed(context, "/files");
            },
            child: Text("Grab Cookies"),
          ),
        ],
      )),
    );
  }
}
