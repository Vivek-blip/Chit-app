import 'package:firebaseflutter2/Screens/Home.dart';
import 'package:firebaseflutter2/AuthScreens/SigninRegistertogler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Services/Firebaseregis.dart';
import 'package:firebaseflutter2/AuthScreens/NotApproved.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';


class Wrapper extends StatelessWidget {

Aprovalcheker(User user)async{
  return await Approval(uid:user.uid).checkApproval();
}

WaiterForApprover()async{


}

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return FutureBuilder(
      future: Aprovalcheker(user),
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

