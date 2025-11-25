// File: lib/models/laporan_model_firebase.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanFirebase {
  // 1. Deklarasi Properti
  // ID dibuat nullable karena saat membuat laporan baru, ID belum ada
  final String? id; 
  
  // Properti lain dibuat final dan non-nullable
  final String namapelapor;
  final String jenisBencana;
  final String judul;
  final String deskripsi;
  final String lokasi;
  final String urgensi;
  final String tanggal;

  // 2. CONSTRUCTOR DIPERBAIKI: Menginisialisasi semua properti final
  LaporanFirebase({
    this.id, // ID tidak required karena bisa null saat create
    required this.namapelapor,
    required this.jenisBencana,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    required this.urgensi,
    required this.tanggal,
  });


  // Metode untuk SQFlite (dihapus jika tidak dipakai)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'namapelapor': namapelapor,
      // ... field lainnya
    };
  }


  // Metode KHUSUS FIREBASE: Mengubah Objek Laporan menjadi Map untuk ditulis
  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{
      'namapelapor': namapelapor,
      'jenisBencana': jenisBencana,
      'judul': judul,
      'deskripsi': deskripsi,
      'lokasi': lokasi,
      'urgensi': urgensi,
      'tanggal': tanggal,
    };
  }

  // Metode KHUSUS FIREBASE: Membuat Objek Laporan dari DocumentSnapshot
  factory LaporanFirebase.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return LaporanFirebase(
      id: doc.id, 
      namapelapor: data['namapelapor'] as String? ?? '', 
      jenisBencana: data['jenisBencana'] as String? ?? '',
      judul: data['judul'] as String? ?? '',
      deskripsi: data['deskripsi'] as String? ?? '',
      lokasi: data['lokasi'] as String? ?? '',
      urgensi: data['urgensi'] as String? ?? '',
      tanggal: data['tanggal'] as String? ?? '',
    );
  }
}