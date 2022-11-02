import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  AppUser({
    required this.uid,
    this.name,
    this.imageURL,
    this.contact,
  });

  final String uid;
  final String? name;
  final String? imageURL;
  final String? contact;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'imageURL': imageURL,
      'contact': contact,
    };
  }

  factory AppUser.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(
      uid: doc.data()!['uid'] as String,
      name: doc.data()!['name'] != null ? doc.data()!['name'] as String : null,
      imageURL: doc.data()!['imageURL'] != null
          ? doc.data()!['imageURL'] as String
          : null,
      contact: doc.data()!['contact'] != null
          ? doc.data()!['contact'] as String
          : null,
    );
  }
}
