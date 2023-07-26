import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_time/models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference collection = _firestore.collection('Events');

class FirestoreEvents {
  static Future<Response> addEvent({
    required String title,
    required String description,
    required String icon,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = collection.doc();

    final data = <String, String>{
      "title": title,
      "description": description,
      "icon": icon
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updateEvent({
    required String title,
    required String description,
    required String icon,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
      "icon": icon
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readEvents() {
    CollectionReference notesItemCollection = collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> deleteEvent({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
