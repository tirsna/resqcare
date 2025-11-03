import 'package:flutter/material.dart';

class DangerZonemaps extends StatelessWidget {
  const DangerZonemaps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView (
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(Icons.map_rounded, color: Colors.green[800], size: 28),
                    SizedBox(width: 8),
                    Text(
                      "Peta Zona Bahaya",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Monitoring real-time area rawan bencana",
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),

                // 🗺️ Bagian PETA — tanpa teks & emot
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orangeAccent.withOpacity(0.7),
                        Colors.redAccent.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/map_preview.png',
                      ), // contoh gambar peta
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // ini simulasi peta (nanti bisa diganti pakai GoogleMap widget)
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.3,
                            child: Container(color: Colors.black12),
                          ),
                        ),
                        // Tombol untuk buka peta interaktif
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FloatingActionButton(
                              backgroundColor: Colors.green[700],
                              onPressed: () {
                                // Aksi buka halaman peta interaktif
                              },
                              child: Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),
                Text(
                  "Legenda Zona Bahaya",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                SizedBox(height: 12),

                // Kartu Zona
                _zonaCard(
                  "Zona Kritis",
                  "Evakuasi segera - Bahaya tinggi",
                  Colors.redAccent,
                  "LEVEL 5",
                ),
                _zonaCard(
                  "Zona Waspada",
                  "Pantau perkembangan",
                  Colors.orangeAccent,
                  "LEVEL 3",
                ),
                _zonaCard(
                  "Zona Perhatian",
                  "Kondisi normal",
                  Colors.blueAccent,
                  "LEVEL 2",
                ),
                _zonaCard(
                  "Zona Aman",
                  "Tidak ada ancaman",
                  Colors.green,
                  "LEVEL 1",
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _zonaCard(String title, String subtitle, Color color, String level) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, radius: 10),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            level,
            style: TextStyle(
              color: const Color.fromARGB(255, 19, 17, 17),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
