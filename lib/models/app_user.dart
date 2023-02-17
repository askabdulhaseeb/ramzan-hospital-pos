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

  factory AppUser.fromMap(Map<String, dynamic> doc) {
    return AppUser(
      uid: doc['uid'] as String,
      name: doc['name'] != null ? doc['name'] as String : null,
      imageURL: doc['imageURL'] != null
          ? doc['imageURL'] as String
          : null,
      contact: doc['contact'] != null
          ? doc['contact'] as String
          : null,
    );
  }
}
