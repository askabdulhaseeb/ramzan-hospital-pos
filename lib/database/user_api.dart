
import 'package:firedart/firedart.dart';

import '../models/app_user.dart';



class UserAPI {
  final CollectionReference _collection =
      Firestore.instance.collection('users');

  Future<void> create(AppUser value) async {
    await _collection.document(value.uid).set(value.toMap());
  }

  Future<AppUser> user(String value) async {
    final Document doc = await _collection.document(value).get();
    return AppUser.fromMap(doc.map);
  }

  Future<List<AppUser>> get() async {
    List<AppUser> value = <AppUser>[];
    List<Document> lis = await _collection
        .get();
    for (int i = 0; i < lis.length; i++) {
      value.add(AppUser.fromMap(lis[i].map));
    }
    return value;
  }
}
