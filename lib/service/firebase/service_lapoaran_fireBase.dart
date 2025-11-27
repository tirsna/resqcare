import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resqcare/models/modellaporan.dart';

class LaporanFirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = "laporan_bencana";

  /// ➕ Tambah laporan + update statistik user
  Future<String> tambahLaporan(LaporanFirebase laporan) async {
    try {
      // 1️⃣ Simpan laporan ke Firestore
      final doc = await _firestore.collection(_collection).add(laporan.toMap());

      // 2️⃣ Update statistik user otomatis
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final userRef = _firestore.collection("users").doc(uid);

      await _firestore.runTransaction((tx) async {
        final snap = await tx.get(userRef);

        if (!snap.exists) {
          tx.set(userRef, {"totalReports": 1, "totalVerified": 0});
        } else {
          final data = snap.data()!;
          tx.update(userRef, {"totalReports": (data["totalReports"] ?? 0) + 1});
        }
      });

      return doc.id;
    } catch (e) {
      throw Exception("Gagal menambah laporan: $e");
    }
  }

  /// 🔁 Ambil semua data realtime
  Stream<List<LaporanFirebase>> getSemuaLaporan() {
    return _firestore.collection(_collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return LaporanFirebase.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>,
        );
      }).toList();
    });
  }

  /// 🔍 Ambil laporan berdasarkan ID
  Future<LaporanFirebase?> getById(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();

      if (!doc.exists || doc.data() == null) return null;

      final data = doc.data() as Map<String, dynamic>;

      return LaporanFirebase(
        id: doc.id,
        namapelapor: data['namapelapor'] ?? '',
        jenisBencana: data['jenisBencana'] ?? '',
        judul: data['judul'] ?? '',
        deskripsi: data['deskripsi'] ?? '',
        lokasi: data['lokasi'] ?? '',
        urgensi: data['urgensi'] ?? '',
        tanggal: data['tanggal'] ?? '',
      );
    } catch (e) {
      throw Exception("Gagal mengambil laporan: $e");
    }
  }

  /// ✏ Update laporan (dipakai admin verifikasi)
  Future<void> updateLaporan(LaporanFirebase laporan) async {
    if (laporan.id == null) {
      throw Exception("ID laporan tidak boleh null saat update!");
    }

    try {
      await _firestore
          .collection(_collection)
          .doc(laporan.id)
          .update(laporan.toMap());
    } catch (e) {
      throw Exception("Gagal update laporan: $e");
    }
  }

  /// ❌ Hapus laporan
  Future<void> hapusLaporan(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception("Gagal menghapus laporan: $e");
    }
  }
}