import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Auth.dart';
import 'package:firebaseflutter2/Screens/chits.dart';
import 'package:firebaseflutter2/Screens/Notification.dart';
import 'package:firebaseflutter2/Screens/Sc_wallet.dart';
import 'package:firebaseflutter2/Screens/My_Account.dart';

class Home extends StatefulWidget {
  final String planApproved;
  Home(this.planApproved);
  @override
  _HomeState createState() => _HomeState(planApproved);
}

class _HomeState extends State<Home> {
  String planApproved;
  _HomeState(this.planApproved);

    final Authentication _auth=Authentication();
    int _currentIndex=0;
    // List<Widget> wgts=[Chits(planApproved),Sc_wallet(),notification(),My_Account()];



    Widget setScreen(int index){
      switch (index) {
        case 0:
          print('switch $planApproved');
          return Chits(planApproved);
        case 1:
          return Sc_wallet();
        case 2:
          return notification();
        case 3:
          return My_Account();
        default:
          return Chits(planApproved);
      }
    }
    // Widget NavigationSelector(int index){
    //   List<Widget> wgts=[Chits(),Sc_wallet(),notification(),My_Account()];
    //   return wgts[index];
    // }

    String AppbarTextSeletor(int index){
      List<String> txt=["Chit","SC Wallet","Notification","My Account"];
      return txt[index];
    }



  @override
  Widget build(BuildContext context) {
      print('home $planApproved');
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
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: setScreen(_currentIndex),
              transitionBuilder: (child,animation){
                return FadeTransition(
                  child: child,
                  opacity:animation,
                );
              },
            ),
            ),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.grey[200],
            unselectedItemColor: Color(0xff59d4e8),
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
              if(planApproved=='active'){
                setState(() {
                _currentIndex=index;
              });
              }
              else{
                if(index!=1){
                  setState(() {
                _currentIndex=index;
                  });
                }
              }
              
            },
          ),
        );
      }
}
