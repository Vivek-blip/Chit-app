import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:firebaseflutter2/Models/NotifiModel.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  int index = 0;
  selectState(List<NotifiData> snp) {
    List<Widget> wgts = [
      Loader(),
      ListviewPg(
        snapshot: snp,
      ),
      Center(
          child: Text(
        'No notifications',
        style: TextStyle(color: Colors.grey[200], fontSize: 18),
      ))
    ];
    return wgts[index];
  }

  fetchNotification(User user) async {
    return await DatabaseService(uid: user.uid).fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return FutureBuilder(
        future: fetchNotification(user),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            index = 0;
          } else if (snapshot.data[0].contentdata == null) {
            index = 2;
          } else {
            index = 1;
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: selectState(snapshot.data),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        });
  }
}

class ListviewPg extends StatefulWidget {
  final List<NotifiData> snapshot;
  ListviewPg({this.snapshot});
  @override
  _ListviewPgState createState() => _ListviewPgState(snapshot);
}

class _ListviewPgState extends State<ListviewPg> {
  final List<NotifiData> snapshot;
  _ListviewPgState(this.snapshot);
  bool check = true;

  showDialoguebox(String title, String content, String url) {
    if (url != '') {
      check = false;
    } else {
      check = true;
    }
    return showDialog(
      context: context,
      barrierDismissible: true,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        child: Container(
          height: 280,
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.red,
                ),
                child: Center(
                    child: Text(
                  '$title',
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 21),
                )),
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  // height: 250,
                  child: Text(
                    '$content',
                    style: TextStyle(color: Colors.grey[800], fontSize: 18),
                  )),
              check
                  ? Text('')
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(url),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.red,
                            child: Text(
                              'Open link',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Webpage(
                                            url: url,
                                          )));
                            },
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: Card(
            color: Color(0xff384757),
            child: ListTile(
              title: Text(
                snapshot[index].titledata,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Container(
                  height: 100,
                  child: Text(
                    snapshot[index].contentdata,
                    style: TextStyle(color: Colors.grey[400]),
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  )),
              trailing: Text(
                snapshot[index].datedata,
                style: TextStyle(color: Colors.grey[300]),
              ),
              onTap: () {
                showDialoguebox(snapshot[index].titledata,
                    snapshot[index].contentdata, snapshot[index].urldata);
              },
            ),
          ),
        );
      },
    );
  }
}

class Webpage extends StatefulWidget {
  final String url;
  Webpage({this.url});
  @override
  _WebpageState createState() => _WebpageState(url);
}

class _WebpageState extends State<Webpage> {
  String url;
  _WebpageState(this.url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text('EDM webview'),
      ),
      url: url,
    );
  }
}
