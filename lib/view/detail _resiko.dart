import 'package:flutter/material.dart';

class DetailResikoPage extends StatelessWidget {
  final String kota;

  const DetailResikoPage({required this.kota, super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy per kota, bisa disesuaikan
    final Map<String, Map<String, String>> dataKota = {
      "Banda Aceh": {
        "risk": "Tinggi",
        "population": "250.000",
        "description":
            "Wilayah rawan tsunami dan banjir akibat curah hujan tinggi.",
      },
      "Lhokseumawe": {
        "risk": "Sedang",
        "population": "190.000",
        "description": "Potensi banjir sedang, infrastruktur cukup memadai.",
      },
      "Medan": {
        "risk": "Tinggi",
        "population": "2,3 Juta",
        "description": "Risiko banjir dan gempa, terutama saat hujan ekstrem.",
      },
      "Bandung": {
        "risk": "Sedang",
        "population": "2,5 Juta",
        "description": "Risiko tanah longsor di beberapa titik dan banjir.",
      },
      "Jakarta Pusat": {
        "risk": "Tinggi",
        "population": "900.000",
        "description": "Rawan banjir, gempa kecil, dan kepadatan tinggi.",
      },
      "Jakarta Selatan": {
        "risk": "Tinggi",
        "population": "1,4 Juta",
        "description":
            "Risiko banjir musiman tinggi dan longsor di perbukitan.",
      },
      "Surabaya": {
        "risk": "Sedang",
        "population": "2,9 Juta",
        "description": "Risiko banjir dan angin kencang di beberapa wilayah.",
      },
      "Denpasar": {
        "risk": "Rendah",
        "population": "800.000",
        "description":
            "Risiko bencana relatif rendah, tetapi tetap waspada terhadap hujan ekstrem.",
      },
      // Tambahkan kota lain sesuai kebutuhan
    };

    // Jika kota tidak ada di data, pakai default
    final kotaData =
        dataKota[kota] ??
        {
          "risk": "Sedang",
          "population": "100.000",
          "description": "Data belum tersedia, potensi risiko sedang.",
        };

    // Fungsi untuk menentukan warna berdasarkan risk
    Color getRiskColor(String risk) {
      switch (risk.toLowerCase()) {
        case 'tinggi':
          return Colors.red;
        case 'sedang':
          return Colors.orange;
        case 'rendah':
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    final riskColor = getRiskColor(kotaData['risk']!);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Risiko - $kota"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kota,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),

            // INDEKS RISIKO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: riskColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: riskColor, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Indeks Risiko: ${kotaData['risk']}",
                      style: TextStyle(
                        color: riskColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // JUMLAH PENDUDUK
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people, color: Colors.blue, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Jumlah Penduduk: ${kotaData['population']}",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Keterangan Tambahan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              kotaData['description']!,
              style: const TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
