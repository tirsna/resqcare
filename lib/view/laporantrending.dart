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
    getData(); // ambil data laporan dari database pas halaman pertama kali dibuka
  }

  //  ambil semua data laporan dari database
  getData() async {
    _listItems = await DbHelper.getLaporanList();
    print(_listItems);
    setState(() {}); // biar UI-nya ke-refresh setelah data diambil
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // warna latar belakang luar halaman
      //  Tombol tambah laporan di pojok kanan bawah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormLaporanDarurat()),
          ).then((context) {
            // setelah balik dari form laporan, refresh data
            setState(() {
              getData();
            });
          });
        },
        child: const Icon(Icons.add),
      ),

      //  Bagian isi utama halaman
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //  Header hijau di atas
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
                children: [
                  // Judul dan ikon laporan
                  Row(
                    children: const [
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
                  const SizedBox(height: 12),
                  const Text(
                    "Kontribusi real-time dari komunitas ResqCare",
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                ],
              ),
            ),

            //  Konten utama berwarna putih
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  //  3 Kotak statistik di atas laporan
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

                  //  Placeholder teks keterangan di atas list laporan
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

                  //  Tampilkan daftar laporan (kalau ada datanya)
                  _listItems != null
                      ? ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // biar gak scroll di dalam scroll
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
                                    //  Baris nama pelapor dan tombol aksi
                                    Row(
                                      children: [
                                        Text(
                                          data.namapelapor ??
                                              "Warga tidak dikenal",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Spacer(),
                                        // Tombol hapus laporan
                                        IconButton(
                                          onPressed: () {
                                            _showDelete(
                                              data.id!,
                                              data.deskripsi,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        // Tombol edit laporan
                                        IconButton(
                                          onPressed: () async {
                                            final result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditLaporanPage(
                                                      laporan: data,
                                                    ),
                                              ),
                                            );
                                            if (result == true) {
                                              getData(); // refresh data setelah laporan diedit
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 6),
                                    // Jenis bencana
                                    Text(
                                      data.jenisBencana ??
                                          "Tidak ada data jenis bencana",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // Deskripsi laporan
                                    Text(
                                      data.deskripsi ??
                                          "Deskripsi tidak tersedia",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // Lokasi laporan
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
                                            data.lokasi ??
                                                "Lokasi belum tercantum",
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
                      : const Text("Belum ada data laporan."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Popup konfirmasi sebelum hapus laporan
  Future<void> _showDelete(int id, String deskripsi) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // biar gak bisa keluar kalau klik di luar dialog
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
                  await DbHelper.deletePelapor(id);
                  if (mounted) {
                    Navigator.of(context).pop(); // tutup dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Laporan berhasil dihapus.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    await getData(); // refresh data setelah hapus
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

  //  Widget kecil buat bikin kartu 
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
