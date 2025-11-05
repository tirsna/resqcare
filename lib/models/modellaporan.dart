import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Laporan {
  final int? id;
  final String namapelapor;
  final String jenisBencana;
  final String judul;
  final String deskripsi;
  final String lokasi;
  final String urgensi;
  final String tanggal;
  Laporan({
    this.id,
    required this.namapelapor,
    required this.jenisBencana,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    required this.urgensi,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'namapelapor': namapelapor,
      'jenisBencana': jenisBencana,
      'judul': judul,
      'deskripsi': deskripsi,
      'lokasi': lokasi,
      'urgensi': urgensi,
      'tanggal': tanggal,
    };
  }

  factory Laporan.fromMap(Map<String, dynamic> map) {
    return Laporan(
      id: map['id'] != null ? map['id'] as int : null,
      namapelapor: map['namapelapor'] as String,
      jenisBencana: map['jenisBencana'] as String,
      judul: map['judul'] as String,
      deskripsi: map['deskripsi'] as String,
      lokasi: map['lokasi'] as String,
      urgensi: map['urgensi'] as String,
      tanggal: map['tanggal'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Laporan.fromJson(String source) =>
      Laporan.fromMap(json.decode(source) as Map<String, dynamic>);
}
