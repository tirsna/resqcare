import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // ID diubah menjadi String untuk menampung UID Firebase
  final String? id; 
  final String username;
  final String email;
  final String password;
  final String kota;
  final int phone;

  UserModel({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.kota,
    required this.phone,
  });

  // Metode KHUSUS FIREBASE: Mengubah Objek UserModel menjadi Map untuk ditulis
  Map<String, dynamic> toFirestore() {
    // Catatan: Password TIDAK boleh disimpan di Firestore!
    // Kita hanya simpan data profil lainnya.
    return {
      'username': username,
      'email': email,
      'kota': kota,
      'phone': phone,
    };
  }

  // Metode KHUSUS FIREBASE: Membuat Objek UserModel dari DocumentSnapshot
  factory UserModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return UserModel(
      id: doc.id, // Ambil UID dari Document ID
      username: data['username'] as String? ?? '',
      email: data['email'] as String? ?? '',
      // Password tidak diambil dari Firestore
      password: '', 
      kota: data['kota'] as String? ?? '',
      phone: data['phone'] as int? ?? 0,
    );
  }
}