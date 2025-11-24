import 'package:flutter/material.dart';

class KontakPentingPage extends StatelessWidget {
  const KontakPentingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Kontak Penting",
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.teal),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.teal.shade100),
            ),
            child: const Text(
              "⚠️ Catatan: Ini hanya tampilan UI (contoh). Tombol Call & Maps belum aktif.",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20),

          _buildContactCard(
            title: "BPBD (Badan Penanggulangan Bencana Daerah)",
            number: "0211234567",
            address: "Kantor BPBD Pusat",
          ),

          _buildContactCard(
            title: "Pemadam Kebakaran",
            number: "113",
            address: "Dinas Damkar Terdekat",
          ),

          _buildContactCard(
            title: "Ambulans / Kesehatan",
            number: "119",
            address: "Pusat Layanan Kesehatan",
          ),

          _buildContactCard(
            title: "Polisi",
            number: "110",
            address: "Kantor Polisi Terdekat",
          ),

          _buildContactCard(
            title: "SAR / Basarnas",
            number: "115",
            address: "Kantor Basarnas",
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required String number,
    required String address,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            // Nomor Telpon
            Row(
              children: [
                Icon(Icons.phone, color: Colors.teal.shade400),
                const SizedBox(width: 10),
                Text(number, style: const TextStyle(fontSize: 14)),
                const Spacer(),
                _softIconButton(Icons.call),
              ],
            ),

            const SizedBox(height: 6),

            // Alamat
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red.shade300),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(address, style: const TextStyle(fontSize: 14)),
                ),
                _softIconButton(Icons.map),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Tombol Icon Soft
  Widget _softIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.teal.shade300),
    );
  }
}
