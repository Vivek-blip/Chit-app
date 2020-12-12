import 'package:cloud_firestore/cloud_firestore.dart';

class VersionCheck {
  final double version = 1.3;
  CollectionReference _versionRef = Firestore.instance.collection("Version");

  Future<bool> versionUptoDate() async {
    try {
      DocumentSnapshot snapshot =
          await _versionRef.document("currentVersion").get();
      double versionNumber = snapshot.data['version'];
      if (versionNumber == version) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
