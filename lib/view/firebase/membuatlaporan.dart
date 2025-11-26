import 'package:flutter/material.dart';
import 'package:resqcare/models/modellaporan.dart';
import 'package:resqcare/service/firebase/service_lapoaran_fireBase.dart';

class FormLaporanPage extends StatefulWidget {
  const FormLaporanPage({super.key});

  @override
  State<FormLaporanPage> createState() => _FormLaporanPageState();
}

class _FormLaporanPageState extends State<FormLaporanPage> {
  final _formKey = GlobalKey<FormState>();

  final namaC = TextEditingController();
  final judulC = TextEditingController();
  final deskC = TextEditingController();
  final lokasiC = TextEditingController();

  String? jenisBencana;
  String? urgensi;

  bool _isLoading = false; // ⬅️ anti click 2× + cegah black screen

  Future<void> _kirim() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final laporan = LaporanFirebase(
        namapelapor: namaC.text,
        jenisBencana: jenisBencana!,
        judul: judulC.text,
        deskripsi: deskC.text,
        lokasi: lokasiC.text,
        urgensi: urgensi!,
        tanggal: DateTime.now().toString(),
      );

      await LaporanFirebaseService().tambahLaporan(laporan);

      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Laporan berhasil dikirim!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal mengirim laporan: $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: const Text(
          "Buat Laporan Bencana",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildInput(
                child: TextFormField(
                  controller: namaC,
                  decoration: _field("Nama Pelapor"),
                  validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                ),
              ),
              const SizedBox(height: 14),

              _buildInput(
                child: DropdownButtonFormField(
                  value: jenisBencana,
                  decoration: _field("Jenis Bencana"),
                  items: ["Banjir", "Gempa", "Kebakaran", "Tanah Longsor"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => jenisBencana = v,
                  validator: (v) => v == null ? "Pilih jenis bencana" : null,
                ),
              ),
              const SizedBox(height: 14),

              _buildInput(
                child: TextFormField(
                  controller: judulC,
                  decoration: _field("Judul Laporan"),
                  validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                ),
              ),
              const SizedBox(height: 14),

              _buildInput(
                child: TextFormField(
                  controller: deskC,
                  maxLines: 3,
                  decoration: _field("Deskripsi Bencana"),
                  validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                ),
              ),
              const SizedBox(height: 14),

              _buildInput(
                child: TextFormField(
                  controller: lokasiC,
                  decoration: _field("Lokasi Kejadian"),
                  validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
                ),
              ),
              const SizedBox(height: 14),

              _buildInput(
                child: DropdownButtonFormField(
                  value: urgensi,
                  decoration: _field("Tingkat Urgensi"),
                  items: ["Rendah", "Sedang", "Tinggi"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => urgensi = v,
                  validator: (v) => v == null ? "Pilih tingkat urgensi" : null,
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _isLoading ? null : _kirim,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Kirim Laporan",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _field(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.teal),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.teal, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
    );
  }

  Widget _buildInput({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
