import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference collection = _firestore.collection('Users');

class FirestoreUser {
  static Stream<QuerySnapshot> readEAdmins() {
    CollectionReference notesItemCollection = collection;

    return notesItemCollection.snapshots();
  }

  static Future<bool> checkAdmin(String uId) async {
    bool val = false;
    await FirebaseFirestore.instance.collection('Users').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (uId == docSnapshot['id']) {
            val = true;
            break;
          }
        }
      },
      onError: (e) => log("Error completing: $e"),
    );
    /*
    var obj = FirestoreUser.readEAdmins().any((adminDocument) =>
        adminDocument.docs.any((element) => element.id == uId));*/
    return val;
  }
}
