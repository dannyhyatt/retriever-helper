import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:retriever_helper/schedule_page.dart';
import 'package:retriever_helper/the_retriever.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xfffdb515)),
      home: MyHomePage(title: 'Retriver Helper'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PersistentTabView(context,
            screens: [
              WebView(
                initialUrl: 'http://localhost:3000',
                javascriptMode: JavascriptMode.unrestricted,
              ),
              OpeningHoursPage(),
              TheRetrieverFeed()
            ],
            items: List<PersistentBottomNavBarItem>.generate(
                3,
                (index) => PersistentBottomNavBarItem(
                      activeColorPrimary: Colors.black,
                      icon: Icon((const [
                        Icons.map,
                        Icons.schedule,
                        Icons.article_outlined
                      ])[index]),
                      textStyle: TextStyle(fontSize: 14),
                      title: (const ['Map', 'Hours', 'News'])[index],
                    )),
            backgroundColor: Theme.of(context).primaryColor));
  }
}
