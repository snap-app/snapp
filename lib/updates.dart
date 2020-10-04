import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:http/http.dart' as http;

class Updates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UpdatesState();
  }
}

class UpdatesState extends State<Updates> {
  var urlList;
  int urlAmount;
  List<String> urls;
  void _parseUrlList() async {
    urlList = await http.read('https://raw.githubusercontent.com/howyay/snapp/master/updates.txt?token=AGYNE7VQA6QO7VIRW2A5AJK7QJAZ2');
    urls = new LineSplitter().convert(urlList);
    urlAmount = urls.length;
  }

  String url;

  @override
  Widget build(BuildContext context) {
    _parseUrlList();
    return Container(
      child: ListView.builder(
        itemCount: urlAmount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              print('retard'),
              url = urls[index],
              _launchURL(context)
            },
            child: Card(
              child: Column(
                children: [
                  Text(urls[index]),
                ],
              ),
            ),
          );
        },
      )
    );
  }

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        '$url',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          // or user defined animation.
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}