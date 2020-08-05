import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Screens/Home.dart';
import 'package:firebaseflutter2/AuthScreens/SigninRegistertogler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Services/Firebaseregis.dart';
import 'package:firebaseflutter2/AuthScreens/NotApproved.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


Stream<DocumentSnapshot> streamupdate(User user){
  if(user==null){
    return null;
  }
  else{
  return Approval(uid:user.uid).checkApproval;
  }
  
}

Widget conditionalWidgetReturner(User user,DocumentSnapshot snapshot){

        if (user==null){
          return SigninRegistertoglerscreen();
        }
        else if(snapshot==null|| snapshot.data==null){
          return Loader();
        }
        else if(snapshot.data['IsApproved']== false){
          return NotApprovedScreen();
        }
        else if(snapshot.data['IsApproved']==true){
          return Home();
        }
        else{
          print(snapshot.data);
          return Loader();
        }

}

 @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamProvider<DocumentSnapshot>.value(
      value: streamupdate(user),
      child: Builder(
        builder: (BuildContext context){
          DocumentSnapshot snapshot=Provider.of<DocumentSnapshot>(context);
          return conditionalWidgetReturner(user, snapshot);
        },
      ),
    );
  }
}

