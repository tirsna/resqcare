import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resqcare/models/firebase/profile_models.dart';

class ProfileService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final String _collection = 'users';

  /// Ambil profil user
  Future<ProfileModel> getProfile(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();

      // Jika dokumen belum ada, buat default profile
      if (!doc.exists || doc.data() == null) {
        final defaultProfile = ProfileModel(
          uid: uid,
          name: "Pengguna ResqCare",
          email: FirebaseAuth.instance.currentUser?.email ?? "-",
          bio: "Relawan aktif yang siap membantu kapan pun.",
          daerahAman: "Bandung",
        );
        await updateProfile(defaultProfile);
        return defaultProfile;
      }

      return ProfileModel.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>,
      );
    } catch (e) {
      print("Error getProfile: $e");
      // Return default jika error
      final uid = FirebaseAuth.instance.currentUser?.uid ?? "";
      return ProfileModel(
        uid: uid,
        name: "Pengguna ResqCare",
        email: FirebaseAuth.instance.currentUser?.email ?? "-",
        bio: "Relawan aktif yang siap membantu kapan pun.",
        daerahAman: "Bandung",
      );
    }
  }

  /// Update profil user
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      final uid = profile.uid ?? FirebaseAuth.instance.currentUser!.uid;
      await _firestore
          .collection(_collection)
          .doc(uid)
          .set(profile.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Error updateProfile: $e");
    }
  }

  /// Upload foto profil dan kembalikan URL
  Future<String?> uploadProfileImage(File file) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = _storage.ref().child('profiles/profile_$uid.png');

      // Upload file
      await storageRef.putFile(file);

      // Ambil download URL
      final downloadUrl = await storageRef.getDownloadURL();

      // Update Firestore
      await _firestore.collection(_collection).doc(uid).set({
        'photoUrl': downloadUrl,
      }, SetOptions(merge: true));

      return downloadUrl;
    } catch (e) {
      print("Error uploadProfileImage: $e");
      return null;
    }
  }

  /// Ambil statistik user
  Future<Map<String, int>> getUserStats(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();
      if (!doc.exists || doc.data() == null) {
        // Buat default statistik
        await _firestore.collection(_collection).doc(uid).set({
          "totalReports": 0,
          "totalVerified": 0,
        }, SetOptions(merge: true));

        return {"totalReports": 0, "totalVerified": 0};
      }
      final data = doc.data()!;
      return {
        "totalReports": data['totalReports'] ?? 0,
        "totalVerified": data['totalVerified'] ?? 0,
      };
    } catch (e) {
      print("Error getUserStats: $e");
      return {"totalReports": 0, "totalVerified": 0};
    }
  }

  /// Update statistik user (misal dipanggil saat user tambah laporan)
  Future<void> updateUserStats({
    required String uid,
    int incrementReports = 0,
    int incrementVerified = 0,
  }) async {
    try {
      final ref = _firestore.collection(_collection).doc(uid);
      await ref.set({
        'totalReports': FieldValue.increment(incrementReports),
        'totalVerified': FieldValue.increment(incrementVerified),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error updateUserStats: $e");
    }
  }
}
