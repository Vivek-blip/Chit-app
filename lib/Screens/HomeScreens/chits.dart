import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Screens/HomeScreens/InfoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebaseflutter2/Screens/HomeScreens/ChitWithPlan.dart';
import 'package:firebaseflutter2/Services/Data_cache.dart';
import 'package:firebaseflutter2/Screens/HomeScreens/UploadReciept.dart';

class Chits extends StatefulWidget {
  final UserdataCache cache;
  Chits(this.cache);
  @override
  _ChitsState createState() => _ChitsState(cache);
}

class _ChitsState extends State<Chits> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  UserdataCache cache;
  _ChitsState(this.cache);

  int index = 0;
  selectState(UserData snp) {
    List<Widget> wgts = [
      Loader(),
      ChitViewpg(snapshot: snp),
      ChitWithPlanViewPg(snapshot: snp),
      PlanNotApprovedScreen()
    ];
    return wgts[index];
  }

  void tokenfetcher() async {
    String token = await _fcm.getToken();
    print(token);
  }

  Future<UserData> fetchUserData(String uid) async {
    if (cache.userData != null) {
      return cache.userData;
    } else {
      return cache.userData = await DatabaseService(uid: uid).fetchUserDoc;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final Map planState = Provider.of<DocumentSnapshot>(context).data;
    return FutureBuilder<UserData>(
        future: fetchUserData(user.uid),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            index = 0;
          } else if (planState['PlanState'] == 'none') {
            index = 2;
          } else if (planState['PlanState'] == 'submitted') {
            index = 3;
          } else if (planState['PlanState'] == 'active') {
            index = 1;
          }
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: selectState(snapshot.data),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
          );
        });
  }
}

class ChitViewpg extends StatefulWidget {
  final UserData snapshot;
  ChitViewpg({this.snapshot});
  @override
  _ChitViewpgState createState() => _ChitViewpgState(snapshot);
}

class _ChitViewpgState extends State<ChitViewpg> {
  final UserData snapshot;
  _ChitViewpgState(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff1B2631),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Welcome ",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[100],
                          fontFamily: "Schyler",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    Text(
                      snapshot.name,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[100],
                          fontFamily: "Schyler",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
            Text(
              "Reg number",
              style: TextStyle(color: Colors.grey[400], fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 70,
            ),
            Text(
              snapshot.regno,
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 15,
            ),
            InfoCard(userData: snapshot),
          ],
        ),
      )),
    );
  }
}

class PlanNotApprovedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff283747),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  "Please wait for your selected plan to get approved",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white, letterSpacing: 1),
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
                child: Text(
              "we will send you a notification on approval",
              style: TextStyle(
                  fontSize: 15, color: Colors.white, letterSpacing: 1),
            )),
          ),
        ],
      ),
    );
  }
}
