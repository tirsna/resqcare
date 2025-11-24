import 'package:flutter/material.dart';
import 'package:resqcare/Home_page/Education.dart';
import 'package:resqcare/Home_page/penyebab.dart';
import 'package:resqcare/view/kontak_penting.dart';
import 'package:resqcare/view/provinsi.dart'; // TAMBAHKAN INI

class Halamanutama extends StatefulWidget {
  const Halamanutama({super.key});

  @override
  State<Halamanutama> createState() => _HalamanutamaState();
}

class _HalamanutamaState extends State<Halamanutama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "ResQCare",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHorizontalCard(
                context,
                Icons.school_rounded,
                "Edukasi Penanganan Bencana",
                "Pelajari langkah aman menghadapi situasi darurat.",
                Colors.teal.shade50,
              ),
              const SizedBox(height: 12),

              _buildHorizontalCard(
                context,
                Icons.public_rounded,
                "Penyebab Bencana",
                "Ketahui faktor-faktor alam & manusia yang memicu bencana.",
                Colors.lightBlue.shade50,
              ),
              const SizedBox(height: 12),

              _buildHorizontalCard(
                context,
                Icons.phone_in_talk_rounded,
                "Kontak Penting",
                "Hubungi instansi terkait untuk bantuan resmi.",
                Colors.green.shade50,
              ),
              const SizedBox(height: 12),

              // 🔥 MENU BARU
              _buildHorizontalCard(
                context,
                Icons.map_rounded,
                "Daftar Provinsi",
                "Lihat semua provinsi, kota, dan indeks risikonya.",
                Colors.orange.shade50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color bgColor,
  ) {
    return InkWell(
      onTap: () {
        if (title == "Edukasi Penanganan Bencana") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EdukasiPenangananPage(),
            ),
          );
        } else if (title == "Penyebab Bencana") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PenyebabBencanaPage(),
            ),
          );
        } else if (title == "Kontak Penting") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KontakPentingPage()),
          );
        } else if (title == "Daftar Provinsi") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProvinsiPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Fitur '$title' masih dalam pengembangan.")),
          );
        }
      },

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.teal.shade700, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF004D40),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.teal,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
