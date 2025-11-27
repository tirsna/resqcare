import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String? uid;
  String name;
  String email;
  String bio;
  String daerahAman;


  ProfileModel({
    this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.daerahAman,

  });

  factory ProfileModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return ProfileModel(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      bio: data['bio'] ?? '',
      daerahAman: data['daerahAman'] ?? '',

    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "bio": bio,
      "daerahAman": daerahAman,

    };
  }
}
