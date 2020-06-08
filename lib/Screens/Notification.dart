import 'package:flutter/material.dart';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:firebaseflutter2/Models/NotifiModel.dart';
import 'package:provider/provider.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Screens/Loading.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {

    
    int index=0;
  selectState(List<NotifiData> snp){
    List<Widget>wgts=[Loader(),ListviewPg(snapshot: snp,),Center(child: Text('No notifications',style: TextStyle(
      color: Colors.grey[200],fontSize: 18
    ),))];
    return wgts[index];
  }

  fetchNotification(User user)async{
    return await DatabaseService(uid: user.uid).fetchNotification();
  }


  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return FutureBuilder(
      future: fetchNotification(user),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.data==null){
         
           index=0;
        
        }
        else if(snapshot.data[0].contentdata==null){
          
            index=2;
         
        }
         else{
           
             index=1;
          
         }
         return AnimatedSwitcher(
           duration: Duration(milliseconds:200),
           child: selectState(snapshot.data),
           transitionBuilder: (child,animation){
             return FadeTransition(
               opacity: animation,
               child: child,
             );
           },
         );
  }
    );
  }
}


class ListviewPg extends StatefulWidget {
  final List<NotifiData>snapshot;
  ListviewPg({this.snapshot});
  @override
  _ListviewPgState createState() => _ListviewPgState(snapshot);
}

class _ListviewPgState extends State<ListviewPg> {
  final List<NotifiData>snapshot;
  _ListviewPgState(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics:BouncingScrollPhysics(),
        itemCount:snapshot.length,
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),),
              color: Color(0xfface6f6),
              shadowColor: Color(0x552f89fc),
              child: ListTile(
                title: Text(snapshot[index].titledata),
                subtitle: Text(snapshot[index].contentdata),
                trailing: Text('data'),
              ),
            ),
          );
        },
        
      );
  }
}
