import 'package:flutter/material.dart';

class DetailResikoPage extends StatelessWidget {
  final String kota;

  const DetailResikoPage({required this.kota, super.key});

  @override
  Widget build(BuildContext context) {
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
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Indeks Risiko: Tinggi",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
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
              child: const Row(
                children: [
                  Icon(Icons.people, color: Colors.blue, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Jumlah Penduduk: 1.2 Juta",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Keterangan Tambahan:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Wilayah ini berpotensi mengalami bencana seperti banjir, gempa, dan angin kencang.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
