import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/models/modellaporan.dart';

// Halaman ini digunakan untuk mengedit laporan yang sudah pernah dibuat
class EditLaporanPage extends StatefulWidget {
  final Laporan laporan;

  const EditLaporanPage({super.key, required this.laporan});

  @override
  State<EditLaporanPage> createState() => _EditLaporanPageState();
}

class _EditLaporanPageState extends State<EditLaporanPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk menampung input dari tiap field
  late TextEditingController namaCtrl;
  late TextEditingController jenisCtrl;
  late TextEditingController judulCtrl;
  late TextEditingController deskCtrl;
  late TextEditingController lokasiCtrl;
  late TextEditingController urgensiCtrl;
  late TextEditingController tanggalCtrl;

  @override
  void initState() {
    super.initState();
    // Isi field dengan data laporan lama biar bisa diedit langsung
    namaCtrl = TextEditingController(text: widget.laporan.namapelapor);
    jenisCtrl = TextEditingController(text: widget.laporan.jenisBencana);
    judulCtrl = TextEditingController(text: widget.laporan.judul);
    deskCtrl = TextEditingController(text: widget.laporan.deskripsi);
    lokasiCtrl = TextEditingController(text: widget.laporan.lokasi);
    urgensiCtrl = TextEditingController(text: widget.laporan.urgensi);
    tanggalCtrl = TextEditingController(text: widget.laporan.tanggal);
  }

  @override
  void dispose() {
    // Bersihin semua controller saat halaman ditutup biar gak bocor memori
    namaCtrl.dispose();
    jenisCtrl.dispose();
    judulCtrl.dispose();
    deskCtrl.dispose();
    lokasiCtrl.dispose();
    urgensiCtrl.dispose();
    tanggalCtrl.dispose();
    super.dispose();
  }

  // Fungsi untuk menyimpan perubahan laporan ke database
  Future<void> _updateLaporan() async {
    if (_formKey.currentState!.validate()) {
      // Buat object laporan baru dengan data yang sudah diedit
      final updated = Laporan(
        id: widget.laporan.id,
        namapelapor: namaCtrl.text,
        jenisBencana: jenisCtrl.text,
        judul: judulCtrl.text,
        deskripsi: deskCtrl.text,
        lokasi: lokasiCtrl.text,
        urgensi: urgensiCtrl.text,
        tanggal: tanggalCtrl.text,
      );

      // Update data di database berdasarkan ID
      final db = await DbHelper.db();
      await db.update(
        DbHelper.tableLaporan,
        updated.toMap(),
        where: 'id = ?',
        whereArgs: [updated.id],
      );

      // Setelah berhasil update, kembali ke halaman sebelumnya
      if (mounted) Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Laporan'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Setiap field input pakai widget khusus biar konsisten tampilannya
              _buildField('Nama Pelapor', namaCtrl),
              _buildField('Jenis Bencana', jenisCtrl),
              _buildField('Judul', judulCtrl),
              _buildField('Deskripsi', deskCtrl, maxLines: 3),
              _buildField('Lokasi', lokasiCtrl),
              _buildField('Urgensi', urgensiCtrl),
              _buildField('Tanggal', tanggalCtrl),

              const SizedBox(height: 24),

              // Tombol simpan perubahan laporan
              ElevatedButton.icon(
                onPressed: _updateLaporan,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Perubahan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00695C),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget pembuat form field biar gak nulis berulang kali
  Widget _buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) {
          // Validasi biar field gak boleh kosong
          if (value == null || value.isEmpty) {
            return '$label wajib diisi';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
