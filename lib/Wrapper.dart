import 'package:firebaseflutter2/Screens/Home.dart';
import 'package:firebaseflutter2/Screens/SigninScrn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);

    if (user==null){
      return signin();
    }
    else{
      return Home();
    }
  }
}

