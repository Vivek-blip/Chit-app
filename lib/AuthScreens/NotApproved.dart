import 'package:flutter/material.dart';

class NotApprovedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
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
                  child: Text("Your account is under verification",style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 1),),
                ),
                 Center(
                  child: Container(child: Text("we will send you a notification on approval",style: TextStyle(fontSize: 15,color: Colors.white,letterSpacing: 1),)),
                ),
              ],
            ),
      ),
    );
  }
}