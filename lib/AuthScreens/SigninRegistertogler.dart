import 'package:flutter/material.dart';
import 'package:firebaseflutter2/AuthScreens/SigninScrn.dart';
import 'package:firebaseflutter2/AuthScreens/RegisterScreen.dart';

class SigninRegistertoglerscreen extends StatefulWidget {
  @override
  _SigninRegistertoglerscreenState createState() => _SigninRegistertoglerscreenState();
}

class _SigninRegistertoglerscreenState extends State<SigninRegistertoglerscreen> {
  bool showSignin=true;

  togglefunc(){
    setState(() {
      showSignin=!showSignin;
    });

  }

  @override
  Widget build(BuildContext context) {
    if(showSignin){
      return Signin(refrsh: togglefunc,);
    }
    else{
      return RegisterPage(refrsh: togglefunc,);
    }
  }
}