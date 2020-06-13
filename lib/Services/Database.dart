import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Models/NotifiModel.dart';
import 'package:intl/intl.dart';


class DatabaseService{

final CollectionReference referance=Firestore.instance.collection('brews');
final CollectionReference notifiReference=Firestore.instance.collection('Notification');
final String uid;
DatabaseService({this.uid});

// Future updateUserdata(String sugars,String name,int strength)async{
//   return await collection.document(uid).setData({
//     'sugars': sugars,
//     'name':name,
//     'strenght':strength,

//   });
// }

UserData snapshotToUserdata(DocumentSnapshot snapshot){
  return UserData(
    name: snapshot.data['name'],
    chitno: snapshot.data['chit no'],
    chit_type: snapshot.data['chit type'],
    chit_validity: snapshot.data['chit validity'],
    accountName: snapshot.data['accountname'],
    accountBranch: snapshot.data['accountbranch'],
    accountNumber: snapshot.data['accountnumber'],
    ifscCode: snapshot.data['ifc code'],
    monthlyAmt: snapshot.data['monthly amt'],
    amount: snapshot.data['amount'],
    regno: snapshot.data['registration id']
  );
}

Future<UserData> get fetchUserDoc async{
  DocumentSnapshot qsnp=await referance.document('$uid').get();
  return snapshotToUserdata(qsnp);
  
}

List<NotifiData> snapshotToNotifidata(DocumentSnapshot snapshot){
  List<NotifiData> list=[];
  
  for(int i=snapshot['message'].length-1 ; i>=0;i--){
    var date=DateTime.fromMicrosecondsSinceEpoch(snapshot['message'][i]['date']*1000);
    var newFormat=DateFormat("dd-MM-yy");
    String formatedDate=newFormat.format(date);
    
    list.add(
      NotifiData(
        title: snapshot['message'][i]['title'],
        content: snapshot['message'][i]['body'],
        url:snapshot['message'][i]['url'] ,
        date: formatedDate
      )
    );
  }
  return list;
}

Future<List<NotifiData>> fetchNotification() async{
 try{
  DocumentSnapshot snp= await notifiReference.document('BroadcastedNotifi').get();
  if(snp['message'].isEmpty){
    return [NotifiData(content: null,title: null,date: null),];
  }
  else{
    return snapshotToNotifidata(snp);
  }
 }catch(e){
   print(e);
   return null;
 }
  

}



}
