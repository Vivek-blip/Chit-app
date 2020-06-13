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

  

 @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder<bool>(
      stream: Approval(uid:user.uid).checkApproval(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if (user==null){
      return SigninRegistertoglerscreen();
      }
        else if(snapshot.data== false){
          return NotApprovedScreen();
        }
        else if(snapshot.data==true){
          return Home();
        }
        else{
          return Loader();
        }
      },
    );
  }
}

