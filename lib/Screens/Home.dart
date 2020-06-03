import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Auth.dart';
import 'package:firebaseflutter2/Screens/chits.dart';
import 'package:firebaseflutter2/Screens/Notification.dart';
import 'package:firebaseflutter2/Screens/Sc_wallet.dart';
import 'package:firebaseflutter2/Screens/My_Account.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    final Authentication _auth=Authentication();
    int _currentIndex=0;

    Widget NavigationSelector(int index){
      List<Widget> wgts=[Chits(),Sc_wallet(),notification(),My_Account()];
      return wgts[index];
    }

    String AppbarTextSeletor(int index){
      List<String> txt=["Chit","SC Wallet","Notification","My Account"];
      return txt[index];
    }



  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[500],
            elevation: 10,
            centerTitle: true,
            title: Text(AppbarTextSeletor(_currentIndex),style: TextStyle(
              fontSize: 28
            ),),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[400],Colors.blue[400]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              )
          ),
            child: NavigationSelector(_currentIndex)),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xff28c7fa),
            elevation: 0,
            iconSize: 28,
            showUnselectedLabels: true,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  backgroundColor: Color(0xff2d6cdf),
                icon: Icon(Icons.attach_money),
                title: Text("Chits")
              ),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xff2d6cdf),
                  icon: Icon(Icons.account_balance_wallet),
                  title: Text("SC Wallet")
              ),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xff2d6cdf),
                  icon: Icon(Icons.notifications),
                  title: Text("Notification")
              ),
              BottomNavigationBarItem(
                  backgroundColor: Color(0xff2d6cdf),
                  icon: Icon(Icons.account_circle),
                  title: Text("My Account")
              )
            ],
            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },
          ),
        );
      }
}
