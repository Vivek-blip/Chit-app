import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';
import 'package:firebaseflutter2/Services/Data_cache.dart';


class My_Account extends StatefulWidget {
  final UserdataCache cache;
  My_Account(this.cache);
  @override
  _My_AccountState createState() => _My_AccountState(cache);
}

class _My_AccountState extends State<My_Account> {
  UserdataCache cache;
  int index=0;
  
  _My_AccountState(this.cache);

  selectState(UserData snp,User user){
    List<Widget>wgts=[Loader(),Listviewpg(snapshot: snp,user: user,)];
    return wgts[index];
  }

  fetchDatafromDatabase(String uid)async{
     if(cache.userData!=null){
      return cache.userData;
    }
    else{
      return cache.userData=await DatabaseService(uid: uid).fetchUserDoc;

    }
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return FutureBuilder(
      future: fetchDatafromDatabase(user.uid),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.data==null){
          index=0;
        }
        else{
          index=1;
        }
        return AnimatedSwitcher(
          duration: Duration(milliseconds:200),
          child: selectState(snapshot.data, user),
          transitionBuilder: (child,animation){
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    );
  }
}


class Listviewpg extends StatefulWidget {
  final User user;
  final UserData snapshot;
  Listviewpg({this.user,this.snapshot});
  @override
  _ListviewpgState createState() => _ListviewpgState(user,snapshot);
}

class _ListviewpgState extends State<Listviewpg> {
  User user;
  bool signoutButtonDisabler=true;


  UserData snapshot;
  _ListviewpgState(this.user,this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListView(
          children:<Widget>[ Column(
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
                snapshot.name,style: TextStyle(
                  fontSize: 30,color: Colors.grey[100],fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
              ),
              ),
            ),
          ),
          ListTile(
            title: Text("Chit number",style: TextStyle(
                fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text(snapshot.chitno,style: TextStyle(
                  fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
              ),),
            ),
          ),
          Divider(
            color:Colors.grey,
            indent: 10,endIndent: 10,
          ),
          ListTile(
            title: Text("Registration ID",style: TextStyle(
                fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text(snapshot.regno,style: TextStyle(
                  fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
              ),),
            ),
          ),
          Divider(
            color:Colors.grey,
            indent: 10,endIndent: 10,
          ),
          ListTile(
            title: Text("Account name",style: TextStyle(
                fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text(snapshot.accountName,style: TextStyle(
                  fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
              ),),
            ),
          ),
          Divider(
            color:Colors.grey,
            indent: 10,endIndent: 10,
          ),
           ListTile(
            title: Text("Account branch",style: TextStyle(
                fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text(snapshot.accountBranch,style: TextStyle(
                  fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
              ),),
            ),
          ),
          Divider(
            color:Colors.grey,
            indent: 10,endIndent: 10,
          ),
           ListTile(
            title: Text("Account number",style: TextStyle(
                fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text(snapshot.accountNumber,style: TextStyle(
                  fontSize: 22,color: Colors.grey[100],fontFamily: "Schyler",letterSpacing: 2
              ),),
            ),
          ),
          Divider(
            color:Colors.grey,
            indent: 10,endIndent: 10,
          ),
           ListTile(
            title: Text("IFSC code",style: TextStyle(
                fontSize: 15,color: Colors.amberAccent,fontFamily: "Schyler",fontWeight: FontWeight.bold,letterSpacing: 2
            ),),
            subtitle: Padding(
              padding: const EdgeInsets.only(top:12.0),
              child: Text(snapshot.ifscCode,style: TextStyle(
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
              if(signoutButtonDisabler){
                signoutButtonDisabler=false;
               await Authentication().signout(user.uid);
               signoutButtonDisabler=true;
              }
            },
          )
        ],
      ),
          ]
    );
  }
}