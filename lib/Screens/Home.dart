import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Auth.dart';
import 'package:firebaseflutter2/Screens/HomeScreens/chits.dart';
import 'package:firebaseflutter2/Screens/Notification.dart';
import 'package:firebaseflutter2/Screens/Sc_wallet.dart';
import 'package:firebaseflutter2/Screens/My_Account.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Services/Data_cache.dart';

import 'HomeScreens/UploadReciept.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Authentication _auth = Authentication();
  int _currentIndex = 0;
  UserdataCache cache;
  // List<Widget> wgts=[Chits(planApproved),Sc_wallet(),notification(),My_Account()];
  @override
  void initState() {
    super.initState();
    cache = UserdataCache();
  }

  Widget setScreen(int index) {
    switch (index) {
      case 0:
        return Chits(cache);
      case 1:
        return Sc_wallet();
      case 2:
        return notification();
      case 3:
        return My_Account(cache);
      default:
        return Chits(cache);
    }
  }
  // Widget NavigationSelector(int index){
  //   List<Widget> wgts=[Chits(),Sc_wallet(),notification(),My_Account()];
  //   return wgts[index];
  // }

  String AppbarTextSeletor(int index) {
    List<String> txt = [
      "Ensure direct money",
      "Wallet",
      "Notification",
      "My Account"
    ];
    return txt[index];
  }

  @override
  Widget build(BuildContext context) {
    final Map plan_State = Provider.of<DocumentSnapshot>(context).data;
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Color(0xff283747),
          leading: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.black,
            backgroundImage: AssetImage(
              "Assets/AppIcon.jpeg",
            ),
          ),
          elevation: 10,
          centerTitle: true,
          title: Text(
            AppbarTextSeletor(_currentIndex),
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
      body: Container(
        color: Color(0xff1B2631),
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: setScreen(_currentIndex),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              child: child,
              opacity: animation,
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          backgroundColor: Color(0xff283747),
          selectedItemColor: Colors.grey[200],
          unselectedItemColor: Color(0xff59d4e8),
          elevation: 0,
          iconSize: 20,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Color(0xff283747),
              icon: Icon(Icons.attach_money),
              label: "Chits",
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xff283747),
              icon: Icon(Icons.account_balance_wallet),
              label: "Wallet",
            ),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff283747),
                icon: Icon(Icons.notifications),
                label: "Notification"),
            BottomNavigationBarItem(
                backgroundColor: Color(0xff283747),
                icon: Icon(Icons.account_circle),
                label: "My Account")
          ],
          onTap: (index) {
            if (plan_State['PlanState'] == 'active') {
              setState(() {
                _currentIndex = index;
              });
            } else {
              if (index != 1) {
                setState(() {
                  _currentIndex = index;
                });
              }
            }
          },
        ),
      ),
    );
  }
}
