import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';
import 'package:firebaseflutter2/Services/Auth.dart';


class Signin extends StatefulWidget {
  final Function refrsh;
  Signin({this.refrsh});
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final Authentication _auth=Authentication();
  final _formkey=GlobalKey<FormState>();
  bool load=false;

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return load ? Loader() : Scaffold(
      resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        backgroundColor: Colors.blue[500],
//        title: Text("Sign-in page",style: TextStyle(fontSize: 28),),
//      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(
          image: AssetImage("Assets/background.jpeg"),
          fit: BoxFit.fill,
          alignment: Alignment.bottomCenter
        )),
        child: Center(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 300,
                  child: Form(
                    key: _formkey ,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 155,),
                        TextFormField(
                          style: TextStyle(fontSize: 20),
                          validator:(val)=>val.isEmpty ? "Enter an email" : null,
                          decoration: InputDecoration(hintText: "Email",
                              contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                              fillColor: Colors.blue[100],
                            filled: true,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue[100],width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue[100],width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue[100],width: 2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue[500],width: 2),
                                borderRadius: BorderRadius.circular(25),
                              )
                          ),
                          onChanged: (val){
                            setState(() {
                              email=val;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          obscureText: true,
                          validator:(val)=>val.length <6 ? "Enter a longer password" : null,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(hintText: "Password",
                              contentPadding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
                              fillColor: Colors.blue[100],
                              filled: true,
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[100],width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[100],width: 2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue[100],width: 2),
                          borderRadius: BorderRadius.circular(15),
                                ),
                         focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.blue[500],width: 2),
                         borderRadius: BorderRadius.circular(25),
                      )
                          ),
                          onChanged: (val){
                            setState(() {
                              password=val;
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                elevation: 5,
                                color: Colors.red[300],
                                child: Text("Sign-in",style: TextStyle(
                                    fontSize: 21,color: Colors.grey[100]
                                ),),
                                onPressed: ()async{
                                  if(_formkey.currentState.validate()){
                                    setState(() {
                                      load=true;
                                    });
                                    dynamic result=await _auth.signinWithEmailAndPsswd(email, password);
                                    if(result==null){
                                      setState(() {
                                        error="Please input valid credentials";
                                        load=false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: Text("Or",style: TextStyle(color: Colors.white,fontSize: 15),
                            ),),
                            Container(
                              height: 48,
                              width: 180,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                elevation: 5,
                                color: Colors.green[300],
                                child: Text("Create account",style: TextStyle(
                                    fontSize: 21,color: Colors.grey[100]
                                ),),
                                onPressed: (){
                                  widget.refrsh();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text(error,style: TextStyle(
                          color: Colors.red
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}