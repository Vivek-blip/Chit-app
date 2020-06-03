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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Your account is under verification",style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 1),),
                ],
              ),
            ),
      ),
    );
  }
}