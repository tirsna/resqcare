import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/models/modellaporan.dart';
import 'package:resqcare/view/membuatlaporan.dart';

class LaporanMasyarakatPage extends StatefulWidget {
  const LaporanMasyarakatPage({super.key});

  @override
  State<LaporanMasyarakatPage> createState() => _LaporanMasyarakatPageState();
}

class _LaporanMasyarakatPageState extends State<LaporanMasyarakatPage> {
  List<Laporan>? _listItems;
  late Laporan _laporan;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    _listItems = await DbHelper.getLaporanList();
    print(_listItems);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // latar belakang luar
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormLaporanDarurat()),
          ).then((context) {
            setState(() {
              getData();
            });
          });
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            // 🔹 Header Hijau
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF00695C),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ikon dan judul
                  Row(
                    children: [
                      Icon(
                        Icons.assignment_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Laporan Masyarakat",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Kontribusi real-time dari komunitas ResqCare",
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // 🔹 Isi konten putih
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Baris statistik
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard(
                        "847",
                        "Laporan Hari Ini",
                        Colors.orangeAccent,
                      ),
                      _buildStatCard("92%", "Akurasi", Colors.green),
                      _buildStatCard("3.2k", "Kontributor", Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Tambahkan konten lain di bawah sini
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "Data laporan terbaru akan muncul di sini...",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),

                  _listItems != null
                      ? ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          shrinkWrap: true,
                          itemCount: _listItems!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = _listItems?[index];
                            return Card(
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data?.namapelapor ??
                                              "warga tidak dikenal",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            _showDelete(
                                              data!.id!,
                                              data.deskripsi,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Icon(Icons.mode_edit,
                                        color: Colors.red,)
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      data?.jenisBencana ??
                                          "warga tidak dikenal",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      data?.deskripsi ?? "warga tidak dikenal",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            data?.lokasi ??
                                                "lokasi bekumtercantum",
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
                        )
                      : Text("Belum ada data"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDelete(int id, String deskripsi) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Hapus Laporan Ini?',
            style: TextStyle(color: Colors.red[700]),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('PERINGATAN:'),
                const SizedBox(height: 8),
                Text(
                  'Menghapus laporan "$deskripsi" akan '
                  'menghapus SEMUA datanya secara permanen.',
                ),
                const SizedBox(height: 12),
                const Text('Tindakan ini tidak dapat dibatalkan.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red[700]),
              child: const Text('Ya, Hapus'),
              onPressed: () async {
                try {
                  await DbHelper.deletePelapor(id);
                  if (mounted) {
                    Navigator.of(context).pop(); // Tutup dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Laporan berhasil dihapus.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await getData(); // 🔥 Refresh list dari DB
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

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
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
