import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter2/Models/RecieptModel.dart';
import 'package:firebaseflutter2/Models/User.dart';
import 'package:firebaseflutter2/Models/NotifiModel.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DatabaseService {
  final CollectionReference referance = Firestore.instance.collection('brews');
  final CollectionReference notifiReference =
      Firestore.instance.collection('Notification');
  final CollectionReference recieptStorageReference =
      Firestore.instance.collection('Reciepts');
  final CollectionReference _walletReference =
      Firestore.instance.collection('Wallet');
  final StorageReference storageReference = FirebaseStorage.instance.ref();
  final String uid;
  DatabaseService({this.uid});

// Future updateUserdata(String sugars,String name,int strength)async{
//   return await collection.document(uid).setData({
//     'sugars': sugars,
//     'name':name,
//     'strenght':strength,

//   });
// }

  UserData snapshotToUserdata(DocumentSnapshot snapshot) {
    //Fetching User details from firebase brews collection
    if (snapshot.data['type'] == "bhagyachit") {
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
        regno: snapshot.data['registration id'],
        chit_nos: snapshot.data['bg_chit_nos'],
        type: snapshot.data['type'],
      );
    } else {
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
        regno: snapshot.data['registration id'],
        type: snapshot.data['type'],
      );
    }
  }

  Future<List> fetchWalletInfo(String uid) async {
    try {
      DocumentSnapshot snapshot = await _walletReference.document(uid).get();
      return snapshot.data['data'];
    } catch (e) {
      return null;
    }
  }

  List<RecieptDataList> recieptDataListMaker(List data) {
    List<RecieptDataList> _list = [];
    data.forEach((element) {
      var date = element['timestamp'].toDate();
      String formatedDate = DateFormat("dd-MM-yy").format(date);
      _list.add(RecieptDataList(
          chitno: element['chitnos'],
          fileurl: element['fileUrl'],
          timeuploaded: formatedDate));
    });
    return _list;
  }

  Future getUploadedReciepts() async {
    try {
      DocumentSnapshot recieptModelData =
          await recieptStorageReference.document("$uid").get();
      return RecieptModel(
          recieptdata: recieptDataListMaker(recieptModelData.data['data']));
    } catch (e) {
      return 'null';
    }
  }

  Future<UserData> get fetchUserDoc async {
    DocumentSnapshot qsnp = await referance.document('$uid').get();
    return snapshotToUserdata(qsnp);
  }

  List<NotifiData> snapshotToNotifidata(DocumentSnapshot snapshot) {
    List<NotifiData> list = [];

    for (int i = snapshot['message'].length - 1; i >= 0; i--) {
      var date = DateTime.fromMicrosecondsSinceEpoch(
          snapshot['message'][i]['date'] * 1000);
      var newFormat = DateFormat("dd-MM-yy");
      String formatedDate = newFormat.format(date);

      list.add(NotifiData(
          title: snapshot['message'][i]['title'],
          content: snapshot['message'][i]['body'],
          url: snapshot['message'][i]['url'],
          date: formatedDate));
    }
    return list;
  }

  Future<List<NotifiData>> fetchNotification() async {
    try {
      DocumentSnapshot snp =
          await notifiReference.document('BroadcastedNotifi').get();
      if (snp['message'].isEmpty) {
        return [
          NotifiData(content: null, title: null, date: null),
        ];
      } else {
        return snapshotToNotifidata(snp);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Upload reciept file to Firestore storage
  Future<String> uploadRecieptFile(
      File file, String chitnos, String regno) async {
    try {
      Timestamp timestamp = Timestamp.now();
      String currentTime = timestamp.seconds.toString();
      StorageTaskSnapshot completed = await storageReference
          .child('PaymentReciepts/$uid/$currentTime')
          .putFile(file)
          .onComplete;
      if (completed.totalByteCount > 0) {
        if (await recieptStorageReference
            .document('$uid')
            .get()
            .then((value) => !value.exists)) {
          await recieptStorageReference
              .document('$uid')
              .setData({"data": [], "regno": regno});
        }
        String downloadUrl = await completed.ref.getDownloadURL();
        dynamic recieptData = {
          'timestamp': timestamp,
          'fileUrl': downloadUrl,
          'chitnos': chitnos
        };
        await recieptStorageReference.document('$uid').updateData(({
              'data': FieldValue.arrayUnion([recieptData])
            }));
        return 'uploaded';
      } else {
        return 'error';
      }
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
