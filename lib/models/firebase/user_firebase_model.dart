// File: lib/models/user_firebase_model.dart

class UserFirebaseModel {
  // Properti Wajib untuk Auth dan Firestore
  final String uid;
  final String email;
  final String username;

  // Properti Tambahan dari Register Screen
  final String nohp;
  final String kota;

  // Properti Timestamp (Sesuai Service Baru)
  final String createdAt;
  final String updatedAt;

  const UserFirebaseModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.nohp, // <<< DITAMBAHKAN
    required this.kota, // <<< DITAMBAHKAN
    required this.createdAt,
    required this.updatedAt,
  });

  // --- Konversi ke Map (untuk .set() atau .update() di Firestore) ---
  Map<String, dynamic> toMap() {
    // UID tidak perlu dimasukkan ke dalam Map karena sudah menjadi ID dokumen
    return {
      'email': email,
      'username': username,
      'nohp': nohp,
      'kota': kota,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // --- Factory untuk membuat objek dari Map (dari Firestore) ---
  // Fungsi ini digunakan di FirebaseService.loginUser
  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    // Tambahkan default value jika field mungkin null di Firestore
    return UserFirebaseModel(
      uid:
          map['uid']
              as String, // UID diambil dari key Map yang ditambahkan di Service
      email: map['email'] as String? ?? '',
      username: map['username'] as String? ?? '',
      nohp: map['nohp'] as String? ?? '', // <<< DITAMBAHKAN
      kota: map['kota'] as String? ?? '', // <<< DITAMBAHKAN
      createdAt:
          map['createdAt'] as String? ?? DateTime.now().toIso8601String(),
      updatedAt:
          map['updatedAt'] as String? ?? DateTime.now().toIso8601String(),
    );
  }
}
