import 'package:flutter/material.dart';

class PetaZonaBahayaPage extends StatelessWidget {
  const PetaZonaBahayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 HEADER ATAS
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF004D40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.map_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Peta Zona Bahaya",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Monitoring real-time area rawan bencana",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 🔹 KOTAK PETA INTERAKTIF
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFE0B2), Color(0xFFFFCCBC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.public_rounded,
                        size: 55,
                        color: Colors.black54,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Peta Interaktif ResqCare",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Real-time disaster monitoring",
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // 🔹 LEGENDA ZONA BAHAYA
                Row(
                  children: const [
                    Icon(
                      Icons.legend_toggle_rounded,
                      color: Colors.teal,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Legenda Zona Bahaya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildZonaCard(
                  title: "Zona Kritis",
                  description: "Evakuasi segera · Bahaya tinggi",
                  color: Colors.redAccent,
                  level: "LEVEL 5",
                ),
                _buildZonaCard(
                  title: "Zona Waspada",
                  description: "Siaga tinggi · Pantau perkembangan",
                  color: Colors.orangeAccent,
                  level: "LEVEL 3",
                ),
                _buildZonaCard(
                  title: "Zona Perhatian",
                  description: "Kondisi normal · Tetap waspada",
                  color: Colors.blueAccent,
                  level: "LEVEL 2",
                ),
                _buildZonaCard(
                  title: "Zona Aman",
                  description: "Area aman · Tidak ada ancaman",
                  color: Colors.green,
                  level: "LEVEL 1",
                ),

                const SizedBox(height: 40),
                // Tambahkan di dalam Column (misal di bawah daftar zona)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD54F), Color(0xFFFFB74D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.pinkAccent,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Lokasi Anda Saat Ini",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Alamat
                      const Text(
                        "JL. MH Thamrin No. 28, Jakarta Pusat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Status Zona
                      Row(
                        children: [
                          const Text(
                            "Status Zona:",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "ZONA AMAN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Kartu tiap zona
  Widget _buildZonaCard({
    required String title,
    required String description,
    required Color color,
    required String level,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 10, backgroundColor: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              level,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
