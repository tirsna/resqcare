// File: lib/service/firebase_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resqcare/models/user_firebase_model.dart';

// Mengubah nama class menjadi PascalCase
class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = "users";

  static Future<UserFirebaseModel> registerUser({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user!;
      final model = UserFirebaseModel(
        uid: user.uid,
        username: username,
        email: email,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
      );
      // Simpan data profil ke Firestore
      await firestore.collection('users').doc(user.uid).set(model.toMap());
      return model;
    } catch (e) {
      // Menangani error umum (misal: Firebase Core Error, Jaringan, dll.)
      print('General Registration Error: $e');
      rethrow;
    }
  }

  static Future<UserFirebaseModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) return null;

      // Ambil data profil dari Firestore
      final snap = await firestore.collection('users').doc(user.uid).get();

      if (!snap.exists) {
        // Ini adalah case yang jarang terjadi jika registrasi berhasil
        return null;
      }

      // Menggabungkan uid dengan data dari Firestore sebelum dikonversi ke Model
      return UserFirebaseModel.fromMap({'uid': user.uid, ...snap.data()!});
    } on FirebaseAuthException catch (e) {
      // Penanganan error kredensial yang spesifik (Sudah sangat baik)
      if (e.code == 'invalid-credential' ||
          e.code == 'wrong-password' ||
          e.code == 'user-not-found') {
        return null; // Mengembalikan null untuk menampilkan pesan error ke user di UI
      }
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      // Menangkap error lain di luar FirebaseAuth
      print('General Login Error: $e');
      rethrow;
    }
  }

  // CREATE
  Future<void> tambahPelapor(UserFirebaseModel user) async {
    await _firestore.collection(_collection).doc(user.uid).set(user.toMap());
  }

  // READ
  // Stream<List<UserFirebaseModel>> getAllPelapor() {
  //   return _firestore.collection(_collection).snapshots().map((snap) {
  //     return snap.docs.map((doc) {
  //       return UserFirebaseModel.fromMap(doc);
  //     }).toList();
  //   });
  // }

  // UPDATE
  Future<void> updatePelapor(UserFirebaseModel user) async {
    await _firestore.collection(_collection).doc(user.uid).update(user.toMap());
  }

  // DELETE
  Future<void> deletePelapor(String uid) async {
    await _firestore.collection(_collection).doc(uid).delete();
  }
}
