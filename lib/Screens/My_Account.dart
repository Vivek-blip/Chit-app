import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';


class My_Account extends StatefulWidget {
  @override
  _My_AccountState createState() => _My_AccountState();
}

class _My_AccountState extends State<My_Account> {


  Widget listviewselector(int index){
    List<Widget> wgts=[

    ];
    return wgts[index];
  }


  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return Column(
      children: <Widget>[
        Container(
          height: 140,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue[400],Colors.indigo[400]],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
          child: Center(
            child: Text(
              "HARI KRISHNAN",style: TextStyle(
                fontSize: 30,color: Colors.grey[100],fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),
            ),
          ),
        ),
        ListTile(
          title: Text("Ph no",style: TextStyle(
              fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
          ),),
          subtitle: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Text("546464",style: TextStyle(
                fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
            ),),
          ),
        ),
        Divider(
          color:Colors.grey,
          indent: 10,endIndent: 10,
        ),
        ListTile(
          title: Text("Adress",style: TextStyle(
              fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
          ),),
          subtitle: Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Text("445 Mount Eden Road, Mount Eden, Auckland.",style: TextStyle(
                fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
            ),),
          ),
        ),
        Divider(
          color:Colors.grey,
          indent: 10,endIndent: 10,
        ),
        SizedBox(height: 30,),
        Container(
          padding: EdgeInsets.all(10),
          width: 300,
          height: 110,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[400],),
          child: Text("About",style: TextStyle(
            color: Colors.white
          ),),
        ),
        SizedBox(height: 40,),
        MaterialButton(
          elevation: 5,
          height: 40,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minWidth: 100,
          color: Colors.red,
          child: Text("Logout",style: TextStyle(
            color: Colors.white,fontSize: 18
          ),),
          onPressed: ()async{
            await Authentication().signout(user.uid);
          },
        )
      ],
    );
  }
}