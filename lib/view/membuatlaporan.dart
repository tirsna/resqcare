import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/database/getlaporan.dart';
import 'package:resqcare/models/modellaporan.dart';

// Halaman utama form laporan darurat
class FormLaporanDarurat extends StatefulWidget {
  const FormLaporanDarurat({super.key});

  @override
  State<FormLaporanDarurat> createState() => _FormLaporanDaruratState();
}

class _FormLaporanDaruratState extends State<FormLaporanDarurat> {
  // 🔹 KEY untuk validasi form (cek input kosong)
  final _formKey = GlobalKey<FormState>();

  // 🔹 Controller berfungsi menangkap teks dari TextField
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _reportNameController = TextEditingController();

  // 🔹 Variabel untuk menyimpan dropdown (dipilih user)
  String? _jenisBencana;
  String? _tingkatUrgensi;

  // 🔹 List berisi pilihan dropdown jenis bencana
  final List<String> jenisBencanaList = [
    'Banjir',
    'Gempa Bumi',
    'Kebakaran',
    'Tanah Longsor',
    'Angin Puting Beliung',
  ];

  // 🔹 List berisi pilihan dropdown tingkat urgensi
  final List<String> urgensiList = ['Rendah', 'Sedang', 'Tinggi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Buat Laporan Darurat"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // 🔹 Kunci form untuk validasi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================== DROPDOWN JENIS BENCANA ====================
              _buildDropdown(
                label: "Jenis Bencana",
                value: _jenisBencana,
                items: jenisBencanaList,
                onChanged: (val) => setState(() => _jenisBencana = val),
              ),

              const SizedBox(height: 15),

              // ==================== INPUT JUDUL LAPORAN ====================
              _buildTextField(
                controller: _judulController,
                label: "Judul Laporan",
                hint: "Contoh: Banjir setinggi 1 meter di Jalan Merdeka",
              ),

              const SizedBox(height: 15),

              // ==================== INPUT DESKRIPSI DETAIL ====================
              _buildTextField(
                controller: _deskripsiController,
                label: "Deskripsi Detail",
                hint: "Jelaskan kondisi bencana dengan detail...",
                maxLines: 4, // 🔹 Agar bisa menulis paragraf panjang
              ),

              const SizedBox(height: 15),

              // ==================== INPUT LOKASI KEJADIAN ====================
              _buildTextField(
                controller: _lokasiController,
                label: "Lokasi Kejadian",
                hint: "Nama jalan, landmark, atau koordinat",
              ),

              const SizedBox(height: 15),

              // ==================== INPUT LOKASI KEJADIAN ====================
              _buildTextField(
                controller: _reportNameController,
                label: "Nama Pelapor",
                hint: "Nama Pelapor",
              ),

              const SizedBox(height: 15),

              // ==================== DROPDOWN TINGKAT URGENSI ====================
              _buildDropdown(
                label: "Tingkat Urgensi",
                value: _tingkatUrgensi,
                items: urgensiList,
                onChanged: (val) => setState(() => _tingkatUrgensi = val),
              ),

              const SizedBox(height: 25),

              // ==================== TOMBOL KIRIM LAPORAN ====================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm, // 🔹 Fungsi kirim laporan
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Kirim Laporan",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== KOMPONEN: TEXT FIELD ====================
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller, // 🔹 Mengambil isi teks dari input
          maxLines: maxLines,
          validator: (val) =>
              val == null || val.isEmpty ? 'Bagian ini wajib diisi' : null,
          decoration: InputDecoration(
            hintText: hint, // 🔹 Teks contoh di dalam field
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  // ==================== KOMPONEN: DROPDOWN ====================
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          initialValue: value,
          hint: Text("Pilih $label"),
          items: items
              .map(
                (item) => DropdownMenuItem(value: item, child: Text(item)),
              ) // 🔹 Menampilkan daftar opsi
              .toList(),
          onChanged: onChanged, // 🔹 Update nilai saat user memilih
          validator: (val) => val == null ? 'Pilih salah satu' : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  // ==================== FUNGSI KIRIM DATA ====================
  void _submitForm() async {
    // 🔹 Cek semua input sudah diisi
    if (_formKey.currentState!.validate()) {
      // 🔹 Kumpulkan semua data dari input form
      final Laporan laporan = Laporan(
        jenisBencana: _jenisBencana!,
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        lokasi: _lokasiController.text,
        urgensi: _tingkatUrgensi!,
        namapelapor: _reportNameController.text,
        tanggal: DateTime.now().toString(),
      );

      // 🔹 Tampilkan hasilnya di console (sementara)
      print("Laporan Terkirim: $laporan");
      await DbHelper.insertLaporan(laporan);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan berhasil dikirim!')),
      );
      // 🔹 Tampilkan notifikasi di bawah layar
    }
  }
}
