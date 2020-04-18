import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart' show Linkify;
import 'package:url_launcher/url_launcher.dart' show canLaunch, launch;

import 'package:uscisquiz/widgets/my_drawer.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    print('[$runtimeType] build');

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  title: Linkify(
                    text:
                        'This app displays the USCIS questions and answers. Here is the official USCIS website. https://www.uscis.gov/citizenship/educators/educational-products/100-civics-questions-and-answers-mp3-audio-english-version',
                    onOpen: (link) async {
                      if (await canLaunch(link.url)) await launch(link.url);
                    },
                    // https://api.flutter.dev/flutter/material/TextTheme-class.html
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
