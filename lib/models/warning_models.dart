import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class Peringatan {
  final String status; // Kritis / Waspada / Info
  final String judul; // Judul peringatan, contoh: "Peringatan Tsunami"
  final String deskripsi; // Penjelasan singkat
  final String lokasi; // Lokasi kejadian
  final String waktu; // Contoh: "3 menit lalu"
  final String level; // Contoh: "Level 5"
  final int jumlahTerpengaruh; // Contoh: 2047
  final Color warnaStatus; // Warna sesuai status
  final IconData icon; // Ikon untuk bencana (tsunami, vulkanik, dll)

  Peringatan({
    required this.status,
    required this.judul,
    required this.deskripsi,
    required this.lokasi,
    required this.waktu,
    required this.level,
    required this.jumlahTerpengaruh,
    required this.warnaStatus,
    required this.icon,
  });
}

List<Peringatan> daftarPeringatan = [
  Peringatan(
    status: "KRITIS",
    judul: "Peringatan Tsunami",
    deskripsi:
        "Gempa 7.4 SR terdeteksi di Samudra Hindia. Potensi tsunami tinggi!",
    lokasi: "Pantai Barat Sumatera, radius 100km",
    waktu: "3 menit lalu",
    level: "Level 5",
    jumlahTerpengaruh: 2047,
    warnaStatus: Colors.red,
    icon: Icons.waves,
  ),
  Peringatan(
    status: "WASPADA",
    judul: "Aktivitas Vulkanik",
    deskripsi:
        "Gunung Merapi meningkatkan aktivitas. Status dinaikkan ke Siaga Level 3.",
    lokasi: "Gunung Merapi, Yogyakarta",
    waktu: "45 menit lalu",
    level: "Level 3",
    jumlahTerpengaruh: 1234,
    warnaStatus: Colors.orange,
    icon: Icons.landscape,
  ),
  Peringatan(
    status: "INFO",
    judul: "Cuaca Ekstrem",
    deskripsi:
        "Hujan lebat dan angin kencang diprediksi hingga 48 jam ke depan.",
    lokasi: "Jabodetabek & sekitarnya",
    waktu: "2 jam lalu",
    level: "Level 2",
    jumlahTerpengaruh: 567,
    warnaStatus: Colors.blue,
    icon: Icons.cloud,
  ),
  
];
