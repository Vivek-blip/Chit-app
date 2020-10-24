import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';
import 'package:firebaseflutter2/Services/Auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Signin extends StatefulWidget {
  final Function refrsh;
  Signin({this.refrsh});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final Authentication _auth = Authentication();
  final _formkey = GlobalKey<FormState>();
  bool load = false;
  final FirebaseMessaging _fmc = FirebaseMessaging();

  String email = '';
  String password = '';
  String error = '';
  String notificationToken;

  //For saving notification token to database
  void fmcTokenFetcher() async {
    notificationToken = await _fmc.getToken();
  }

  @override
  void initState() {
    super.initState();
    fmcTokenFetcher();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.black,
            resizeToAvoidBottomInset: false,
            body: Stack(
                alignment: AlignmentDirectional.center,
                fit: StackFit.passthrough,
                children: <Widget>[
                  Positioned.fill(
                      child: Image.asset(
                    "Assets/background.jpg",
                    fit: BoxFit.fill,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return AnimatedOpacity(
                        child: child,
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.decelerate,
                      );
                    },
                  )),
                  Container(
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         image: AssetImage("Assets/background.jpg"),
                    //         fit: BoxFit.fill,
                    //         alignment: Alignment.bottomCenter)),
                    child: Center(
                      child: Scaffold(
                        resizeToAvoidBottomInset: true,
                        backgroundColor: Colors.transparent,
                        body: Center(
                          child: SingleChildScrollView(
                            child: Container(
                              width: 300,
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 155,
                                    ),
                                    TextFormField(
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      validator: (val) =>
                                          val.isEmpty ? "Enter an email" : null,
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: "Email",
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      validator: (val) => val.length < 6
                                          ? "Enter a longer password"
                                          : null,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                        labelText: "Password",
                                        fillColor: Colors.white,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(),
                                        ),
                                        //fillColor: Colors.green
                                      ),
                                      onChanged: (val) {
                                        setState(() {
                                          password = val;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 30),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          height: 48,
                                          width: 180,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            elevation: 5,
                                            color: Colors.red[300],
                                            child: Text(
                                              "Sign-in",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  color: Colors.grey[100]),
                                            ),
                                            onPressed: () async {
                                              if (_formkey.currentState
                                                      .validate() &&
                                                  notificationToken != null) {
                                                setState(() {
                                                  load = true;
                                                });
                                                dynamic result = await _auth
                                                    .signinWithEmailAndPsswd(
                                                        email,
                                                        password,
                                                        notificationToken);
                                                if (result == null) {
                                                  setState(() {
                                                    error =
                                                        "Please input valid credentials";
                                                    load = false;
                                                  });
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                          child: Text(
                                            "____________",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Container(
                                          height: 48,
                                          width: 180,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            elevation: 5,
                                            color: Colors.green[300],
                                            child: Text(
                                              "Create account",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey[100]),
                                            ),
                                            onPressed: () {
                                              widget.refrsh();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      error,
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
          );
  }
}
