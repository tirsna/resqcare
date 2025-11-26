import 'package:flutter/material.dart';
import 'package:resqcare/models/modellaporan.dart';
import 'package:resqcare/service/firebase/service_lapoaran_fireBase.dart';
import 'package:resqcare/view/firebase/editlaporan.dart';
import 'package:resqcare/view/firebase/membuatlaporan.dart';

class LaporanMasyarakatPage extends StatelessWidget {
  const LaporanMasyarakatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          "Laporan Masyarakat",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // 🔥 FAB BUTTON TAMBAH (Estetik)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormLaporanPage()),
          );
        },
      ),

      body: StreamBuilder<List<LaporanFirebase>>(
        stream: LaporanFirebaseService().getSemuaLaporan(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final list = snapshot.data!;
          if (list.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada laporan.",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final d = list[i];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),

                  // TITLE LAPORAN
                  title: Text(
                    d.judul,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  // SUBTITLE (Jenis Bencana)
                  subtitle: Text(
                    d.jenisBencana,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),

                  // ICON ACTIONS
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.teal),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditLaporanPage(laporan: d),
                            ),
                          );
                        },
                      ),

                      // Delete Button
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          LaporanFirebaseService().hapusLaporan(d.id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
