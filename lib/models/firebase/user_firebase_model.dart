// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserFirebaseModel1 {
//   // Properti utama
//   final String uid;
//   final String email;
//   final String username;

//   // Properti tambahan
//   final String nohp;
//   final String kota;

//   // Timestamp
//   final String createdAt;
//   final String updatedAt;

//   const UserFirebaseModel1({
//     required this.uid,
//     required this.email,
//     required this.username,
//     required this.nohp,
//     required this.kota,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   // Convert object -> Map (untuk Firestore)
//   Map<String, dynamic> toMap() {
//     return {
//       'email': email,
//       'username': username,
//       'nohp': nohp,
//       'kota': kota,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }

//   // Convert Map -> object (dipakai ketika login)
//   factory UserFirebaseModel1.fromMap(Map<String, dynamic> map) {
//     return UserFirebaseModel1(
//       uid: map['uid'] ?? '',
//       email: map['email'] ?? '',
//       username: map['username'] ?? '',
//       nohp: map['nohp'] ?? '',
//       kota: map['kota'] ?? '',
//       createdAt: map['createdAt'] ?? '',
//       updatedAt: map['updatedAt'] ?? '',
//     );
//   }

//   // Convert DocumentSnapshot -> object (dipakai FirestoreService)
//   factory UserFirebaseModel1.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;

//     return UserFirebaseModel1(
//       uid: doc.id, // auto ambil ID dokumen
//       email: data['email'] ?? '',
//       username: data['username'] ?? '',
//       nohp: data['nohp'] ?? '',
//       kota: data['kota'] ?? '',
//       createdAt: data['createdAt'] ?? '',
//       updatedAt: data['updatedAt'] ?? '',
//     );
//   }
// }
