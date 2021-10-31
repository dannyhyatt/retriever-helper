import 'package:flutter/material.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';

class TheRetrieverFeed extends StatefulWidget {
  const TheRetrieverFeed({Key? key}) : super(key: key);

  @override
  _TheRetrieverFeedState createState() => _TheRetrieverFeedState();
}

class _TheRetrieverFeedState extends State<TheRetrieverFeed> {
  late RssFeed feed;
  String state = 'loading';

  @override
  void initState() {
    super.initState();
    () async {
      http.Response response =
          await http.post(Uri.parse('https://api.sga.umbc.edu/news'));
      debugPrint('got response: ${response.body}');
      setState(() {
        feed = RssFeed.parse(response.body);
        state = 'loaded';
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    if (state == 'loading')
      return Center(
        child: CircularProgressIndicator(),
      );

    return ListView.builder(
        itemCount: feed.items?.length,
        itemBuilder: (ctx, index) {
          debugPrint('hello: hi');
          return ListTile(
            contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            title: Text(
              feed.items?[index].title ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(HtmlCharacterEntities.decode(
                feed.items?[index].description ?? '')),
            onTap: () {
              debugPrint(feed.items?[index].link);
              launch(feed.items?[index].link ?? '', forceWebView: true);
            },
          );
        });
  }
}
