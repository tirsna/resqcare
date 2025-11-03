import 'package:flutter/material.dart';

class LaporanDaruratPage extends StatefulWidget {
  @override
  _LaporanDaruratPageState createState() => _LaporanDaruratPageState();
}

class _LaporanDaruratPageState extends State<LaporanDaruratPage> {
  String? jenisBencana;
  String? tingkatUrgensi;
  final TextEditingController judulController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.report,
                      color: const Color.fromARGB(255, 255, 0, 0),
                      size: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Buat Laporan Darurat",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "Bantu komunitas dengan melaporkan kondisi di sekitar Anda",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                SizedBox(height: 20),

                // Jenis Bencana
                Text(
                  "Jenis Bencana",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Pilih jenis bencana yang terjadi",
                    prefixIcon: Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: jenisBencana,
                  items: ['Banjir', 'Gempa', 'Kebakaran', 'Tanah Longsor']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => jenisBencana = val),
                ),
                SizedBox(height: 16),

                // Judul Laporan
                Text(
                  "Judul Laporan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: judulController,
                  decoration: InputDecoration(
                    hintText: "Contoh: Banjir setinggi 1 meter di depan rumah",
                    prefixIcon: Icon(Icons.title, color: Colors.blueAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Deskripsi Detail
                Text(
                  "Deskripsi Detail",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: deskripsiController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        "Jelaskan kondisi yang Anda lihat secara detail...",
                    prefixIcon: Icon(Icons.description, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Lokasi Kejadian
                Text(
                  "Lokasi Kejadian",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: lokasiController,
                  decoration: InputDecoration(
                    hintText: "Nama jalan, landmark, atau koordinat",
                    prefixIcon: Icon(Icons.location_on, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Tingkat Urgensi
                Text(
                  "Tingkat Urgensi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: "Pilih tingkat urgensi",
                    prefixIcon: Icon(
                      Icons.priority_high,
                      color: Colors.deepOrange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: tingkatUrgensi,
                  items: ['Rendah', 'Sedang', 'Tinggi']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => tingkatUrgensi = val),
                ),
                SizedBox(height: 24),

                // Tombol Kirim
                ElevatedButton.icon(
                  onPressed: () {
                    // Aksi ketika tombol ditekan
                    print("Jenis: $jenisBencana");
                    print("Judul: ${judulController.text}");
                    print("Deskripsi: ${deskripsiController.text}");
                    print("Lokasi: ${lokasiController.text}");
                    print("Urgensi: $tingkatUrgensi");
                  },
                  icon: Icon(Icons.send),
                  label: Text("Kirim Laporan"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
