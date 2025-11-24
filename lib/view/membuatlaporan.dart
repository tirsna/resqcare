import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/models/modellaporan.dart';

class FormLaporanDarurat extends StatefulWidget {
  const FormLaporanDarurat({super.key});

  @override
  State<FormLaporanDarurat> createState() => _FormLaporanDaruratState();
}

class _FormLaporanDaruratState extends State<FormLaporanDarurat> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _reportNameController = TextEditingController();

  String? _jenisBencana;
  String? _tingkatUrgensi;

  final List<String> jenisBencanaList = [
    'Banjir',
    'Gempa Bumi',
    'Kebakaran',
    'Tanah Longsor',
    'Angin Puting Beliung',
  ];

  final List<String> urgensiList = ['Rendah', 'Sedang', 'Tinggi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Buat Laporan Darurat",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDropdown(
                  label: "Jenis Bencana",
                  value: _jenisBencana,
                  items: jenisBencanaList,
                  onChanged: (val) => setState(() => _jenisBencana = val),
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _judulController,
                  label: "Judul Laporan",
                  hint: "Contoh: Banjir setinggi 1 meter di Jalan Merdeka",
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _deskripsiController,
                  label: "Deskripsi Detail",
                  hint: "Jelaskan kondisi bencana dengan detail...",
                  maxLines: 4,
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _lokasiController,
                  label: "Lokasi Kejadian",
                  hint: "Nama jalan, landmark, atau koordinat",
                ),
                const SizedBox(height: 18),

                _buildTextField(
                  controller: _reportNameController,
                  label: "Nama Pelapor",
                  hint: "Masukkan nama pelapor",
                ),
                const SizedBox(height: 18),

                _buildDropdown(
                  label: "Tingkat Urgensi",
                  value: _tingkatUrgensi,
                  items: urgensiList,
                  onChanged: (val) => setState(() => _tingkatUrgensi = val),
                ),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    label: const Text(
                      "Kirim Laporan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          validator: (val) =>
              val == null || val.isEmpty ? 'Bagian ini wajib diisi' : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black45, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade600, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          hint: Text("Pilih $label"),
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          validator: (val) => val == null ? 'Pilih salah satu' : null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal.shade600, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Laporan laporan = Laporan(
        jenisBencana: _jenisBencana!,
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        lokasi: _lokasiController.text,
        urgensi: _tingkatUrgensi!,
        namapelapor: _reportNameController.text,
        tanggal: DateTime.now().toString(),
      );

      await DbHelper.insertLaporan(laporan);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Laporan berhasil dikirim!'),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }
}
