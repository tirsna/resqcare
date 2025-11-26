import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanFirebase {
  String? id;
  String namapelapor;
  String jenisBencana;
  String judul;
  String deskripsi;
  String lokasi;
  String urgensi;
  String tanggal;

  LaporanFirebase({
    this.id,
    required this.namapelapor,
    required this.jenisBencana,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    required this.urgensi,
    required this.tanggal,
  });

  factory LaporanFirebase.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
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
  }

  Map<String, dynamic> toMap() {
    return {
      "namapelapor": namapelapor,
      "jenisBencana": jenisBencana,
      "judul": judul,
      "deskripsi": deskripsi,
      "lokasi": lokasi,
      "urgensi": urgensi,
      "tanggal": tanggal,
    };
  }
}
