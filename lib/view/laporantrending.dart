import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/models/modellaporan.dart';
import 'package:resqcare/view/editlaporan.dart';
import 'package:resqcare/view/membuatlaporan.dart';

class LaporanMasyarakatPage extends StatefulWidget {
  const LaporanMasyarakatPage({super.key});

  @override
  State<LaporanMasyarakatPage> createState() => _LaporanMasyarakatPageState();
}

class _LaporanMasyarakatPageState extends State<LaporanMasyarakatPage> {
  List<Laporan>? _listItems;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Ambil semua data laporan dari database
  Future<void> getData() async {
    final data = await DbHelper.getLaporanList();
    setState(() {
      _listItems = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormLaporanDarurat()),
          ).then((_) {
            getData(); // refresh setelah kembali dari form
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header hijau
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF00695C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.report_problem, color: Colors.white, size: 28),
                      SizedBox(width: 8),
                      Text(
                        "Laporkan Masalah Anda",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Kontribusi real-time dari komunitas ResqCare",
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Konten utama
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Statistik kecil
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard("847", "Laporan Hari Ini", Colors.orangeAccent),
                      _buildStatCard("92%", "Akurasi", Colors.green),
                      _buildStatCard("3.2k", "Kontributor", Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Teks keterangan
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "Data laporan terbaru akan muncul di bawah ini...",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tampilkan daftar laporan
                  if (_listItems == null)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    )
                  else if (_listItems!.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Belum ada data laporan."),
                    )
                  else
                    ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _listItems!.length,
                      itemBuilder: (context, index) {
                        final data = _listItems![index];
                        return Card(
                          color: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Baris nama pelapor dan tombol aksi
                                Row(
                                  children: [
                                    Text(
                                      data.namapelapor ?? "Warga tidak dikenal",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        _showDelete(
                                          data.id ?? 0,
                                          data.deskripsi ?? '',
                                        );
                                      },
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditLaporanPage(
                                              laporan: data,
                                            ),
                                          ),
                                        );
                                        if (result == true) getData();
                                      },
                                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                // Jenis bencana
                                Text(
                                  data.jenisBencana ?? "Tidak ada data jenis bencana",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                // Deskripsi
                                Text(
                                  data.deskripsi ?? "Deskripsi tidak tersedia",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                // Lokasi
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, color: Colors.red, size: 16),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        data.lokasi ?? "Lokasi belum tercantum",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Popup konfirmasi hapus
  Future<void> _showDelete(int id, String deskripsi) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Hapus Laporan Ini?',
            style: TextStyle(color: Colors.red[700]),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('⚠️ PERINGATAN:'),
                const SizedBox(height: 8),
                Text(
                  'Menghapus laporan "$deskripsi" akan menghapus datanya secara permanen.',
                ),
                const SizedBox(height: 12),
                const Text('Tindakan ini tidak dapat dibatalkan.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red[700]),
              child: const Text('Ya, Hapus'),
              onPressed: () async {
                try {
                  await DbHelper.deletePelapor(id); // pastikan nama method ini sesuai di DbHelper
                  if (mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Laporan berhasil dihapus.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await getData();
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal menghapus laporan: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Widget kecil untuk kartu statistik
  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
