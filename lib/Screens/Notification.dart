import 'package:flutter/material.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics:BouncingScrollPhysics(),
      itemCount:10,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),),
            color: Color(0xfface6f6),
            shadowColor: Color(0x552f89fc),
            child: ListTile(
              title: Text("hello"),
            ),
          ),
        );
      },
      
    );
  }
}


