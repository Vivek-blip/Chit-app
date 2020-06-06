import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter2/Services/Database.dart';
import 'package:firebaseflutter2/Models/User.dart';

class Authentication{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final CollectionReference reference=Firestore.instance.collection('Approval');

  //Create user obj
  User _userfromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //Auth change
  Stream<User> get authChange{
    return _auth.onAuthStateChanged
          .map(_userfromFirebase);
}

  // Signin anonimously
  // Future signinaAnon()async{
  //   try{
  //     AuthResult result=await _auth.signInAnonymously();
  //     FirebaseUser user=result.user;
  //     await DatabaseService(uid: user.uid).updateUserdata("65", "VIVEK", 100);
  //     return _userfromFirebase(user);
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //Register with email and password
  Future signinWithEmailAndPsswd(String Email,String password,String fmcToken)async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: Email, password: password);
      FirebaseUser user = result.user;
      String uid=user.uid;
      await reference.document('$uid').updateData({
        'fmcToken':fmcToken
      });
      return _userfromFirebase(user);
    }
    catch(e){
      return null;
    }
  }

  //Signout

  Future signout(String uid)async{
    try{
      await reference.document('$uid').updateData({
        'fmcToken':'fmcToken'
      });
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }

}