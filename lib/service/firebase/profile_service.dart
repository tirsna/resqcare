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
  Future<ProfileModel?> getProfile(String uid) async {
    try {
      final doc = await _firestore.collection(_collection).doc(uid).get();
      if (!doc.exists || doc.data() == null) return null;
      return ProfileModel.fromFirestore(
        doc as DocumentSnapshot<Map<String, dynamic>>,
      );
    } catch (e) {
      print("Error getProfile: $e");
      return null;
    }
  }

  /// Update profil user
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(profile.uid)
          .set(profile.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Error updateProfile: $e");
    }
  }

  /// Upload foto profil dan kembalikan URL
  Future<String?> uploadProfileImage(File file) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final storageRef = _storage.ref().child('profiles/profile_$uid.png');

      // Upload
      await storageRef.putFile(file);

      // Ambil URL
      final downloadUrl = await storageRef.getDownloadURL();

      // Update di Firestore
      await _firestore.collection(_collection).doc(uid).set({
        'photoUrl': downloadUrl,
      }, SetOptions(merge: true));

      return downloadUrl;
    } catch (e) {
      print("Error uploadProfileImage: $e");
      return null;
    }
  }
}
