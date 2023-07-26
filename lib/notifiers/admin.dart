// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:wedding_time/services/fireStore/user.dart';

class AdminNotifier extends ChangeNotifier {
  Future<bool> checkAdmin(String uId) async {
    /*
    bool idAdmin = await FirestoreUser.readEAdmins().any((adminDocument) =>
        adminDocument.docs.any((element) => element.id == uId));
    return idAdmin;*/
    return await FirestoreUser.checkAdmin(uId);
  }
}
