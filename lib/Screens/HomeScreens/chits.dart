import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Models/User.dart';
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
  
  final FirebaseMessaging _fcm=FirebaseMessaging();
  UserdataCache cache;
  _ChitsState(this.cache);
  // @override
  // void initState(){
  //   super.initState();
  //   _fcm.configure(
  //     onMessage: (Map<String,dynamic>message)async{
  //       print(message);
  //       showDialog(
  //               context: context,
  //               builder: (context) => AlertDialog(
  //                       content: ListTile(
  //                       title: Text(message['notification']['title']),
  //                       subtitle: Text(message['notification']['body']),
  //                       ),
  //                       actions: <Widget>[
  //                       FlatButton(
  //                           child: Text('Ok'),
  //                           onPressed: () => Navigator.of(context).pop(),
  //                       ),
  //                   ],
  //               ),
  //           );
  //     },
  //   );
    
  // }

   int index=0;
  selectState(UserData snp){
    List<Widget>wgts=[Loader(),ChitViewpg(snapshot:snp),ChitWithPlanViewPg(snapshot:snp),PlanNotApprovedScreen()];
    return wgts[index];
  }

  

  void tokenfetcher()async{
    String token=await _fcm.getToken();
    print(token);
  }

  Future<UserData> fetchUserData(String uid)async{
    if(cache.userData!=null){
      return cache.userData;
    }
    else{
      return cache.userData=await DatabaseService(uid: uid).fetchUserDoc;

    }
  }


  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    final Map  planState=Provider.of<DocumentSnapshot>(context).data;
    return FutureBuilder<UserData>(
        future: fetchUserData(user.uid),
        builder: (context, snapshot) {
        if(snapshot.data==null){
          index=0;
        }
        else if(planState['PlanState']=='none'){
          index=2;
        }
        else if(planState['PlanState']=='submitted'){
          index=3;
          
        }
        else if(planState['PlanState']=='active'){
          index=1;
          
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds:200),
          child: selectState(snapshot.data),
          transitionBuilder: (child,animation){
            return FadeTransition(
              opacity:animation,
              child:child
            );
          },
        );
  }
    );
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.indigo[400],Colors.blue[400]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
              )
          ),
          child: Center(
            child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
      Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Text("Welcome ",style: TextStyle(
      fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
      ),),
      Text(snapshot.name,
          style: TextStyle(
      fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
      ),),
      ],
      ),
      SizedBox(height: 50,),
      // Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // children: <Widget>[
      // Text("Chit No : ",style: TextStyle(
      // fontSize: 18,color: Colors.amber[200],fontFamily: "Schyler",fontWeight: FontWeight.bold
      // ),),
      // Text(snapshot.chitno,style: TextStyle(
      // fontSize: 22,color: Colors.white,fontFamily: "Schyler"
      // ),),
      // ],
      // ),
      ],
      ),
      Container(
        padding: EdgeInsets.fromLTRB(6, 6, 6, 0),
        height: 238,
        width: 280,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Text("welcome",
            style: TextStyle(
        fontWeight: FontWeight.w400,letterSpacing: 1.8,
        fontSize: 34
        ),),
        ),
        Image(image: AssetImage("Assets/home page.png"),),
        ],
        )),
       Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 0,),
            Container(
              height: 80,
              width: 170,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0x4fa1eafb),
              boxShadow:[BoxShadow(blurRadius: 8,spreadRadius: 1,color: Color(0x552f89fc))], 
              ),
              child: Center(
                child: Text(snapshot.chit_type,style: TextStyle(
                        fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",fontWeight: FontWeight.bold
                    ),),
              ),
            ),
           MaterialButton(
              height: 80,
              minWidth: 170,
              padding: EdgeInsets.all(6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Color(0x4fa1eafb),
              child:Center(
                child: Text("Upload Reciept",style: TextStyle(
                        fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",fontWeight: FontWeight.bold
                    ),),
              ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>UploadRecieptScrn()));
              },
            )
          ],
      ),
      ],
      ),
      )
      ),
        );
  }
}

class PlanNotApprovedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.indigo[400],Colors.blue[400]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    child: Text("Please wait for your selected plan to get approved",style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 1),)),
                ),
                SizedBox(height: 30,),
                 Center(
                  child: Container(child: Text("we will send you a notification on approval",style: TextStyle(fontSize: 15,color: Colors.white,letterSpacing: 1),)),
                ),
              ],
            ),
      );
  }
}


