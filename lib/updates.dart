import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom;
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';

class Updates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UpdatesState();
  }
}

class UpdatesState extends State<Updates> {
  int urlAmount;
  List<String> urls;
  String url;
  String title;

  Future<String> _parseUrlList() async {
    var urlList = await http.read(
        'https://raw.githubusercontent.com/howyay/snapp/master/updates.txt?token=AGYNE7VQA6QO7VIRW2A5AJK7QJAZ2');
    urls = new LineSplitter().convert(urlList);
    urlAmount = urls.length;
  }

  Future<String> _getTitle(int index) async {
    var response = await http.get(urls[index]);
    var document = responseToDocument(response);
    var data = MetadataParser.htmlMeta(document);
    return title = data.title;
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: _parseUrlList(),
    //   builder: (context, snapshot) {
    //     return Container(
    //       child: ListView.builder(
    //         itemCount: urlAmount,
    //         itemBuilder: (context, index) {
    //           return GestureDetector(
    //             onTap: () async {
    //               await custom.launch(
    //                 '$url',
    //                 option: new custom.CustomTabsOption(
    //                   toolbarColor: Theme.of(context).primaryColor,
    //                   enableDefaultShare: true,
    //                   enableUrlBarHiding: true,
    //                   showPageTitle: true,
    //                   animation: new custom.CustomTabsAnimation.slideIn(),
    //                   extraCustomTabs: <String>[
    //                     // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
    //                     'org.mozilla.firefox',
    //                     // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
    //                     'com.microsoft.emmx',
    //                   ],
    //                 ),
    //               );
    //             },
    //             child: Card(
    //               child: Column(
    //                 children: [
    //                   FutureBuilder(
    //                     future: _getTitle(index),
    //                     builder: (context, snapshot) {
    //                       return Text(title);
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       ),
    //     );
    //   },
    // );
    return FutureBuilder(
      future: _parseUrlList(),
      builder: (context,snapshot) {
        return Container(
          child: ListView.builder(
            itemCount: urlAmount,
            itemBuilder: (context, index) {
              return Card(
                child: Text('${urls[index]}'),
              );
            },
          ),
        );
      },
    );
  }
}
