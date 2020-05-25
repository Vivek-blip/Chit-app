import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Models/User.dart';

class DatabaseService{

final CollectionReference collection=Firestore.instance.collection("brews");
final String uid;
DatabaseService({this.uid});

Future updateUserdata(String sugars,String name,int strength)async{
  return await collection.document(uid).setData({
    'sugars': sugars,
    'name':name,
    'strenght':strength,

  });
}

UserData snapshotToUserdata(DocumentSnapshot snapshot){
  return UserData(
    name: snapshot.data['name'],
    chitno: snapshot.data['chit no'],
    chit_type: snapshot.data['chit type'],
    chit_validity: snapshot.data['chit validity']
  );
}


 Stream<UserData> get fetchUserData{
    return  collection.document(uid).snapshots()
    .map(snapshotToUserdata);
}

}