import 'package:flutter/material.dart';
import 'package:resqcare/models/modellaporan.dart';
import 'package:resqcare/service/firebase/service_lapoaran_fireBase.dart';

class EditLaporanPage extends StatefulWidget {
  final LaporanFirebase laporan;
  const EditLaporanPage({super.key, required this.laporan});

  @override
  State<EditLaporanPage> createState() => _EditLaporanPageState();
}

class _EditLaporanPageState extends State<EditLaporanPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaC;
  late TextEditingController judulC;
  late TextEditingController deskC;
  late TextEditingController lokasiC;

  String? jenisBencana;
  String? urgensi;

  @override
  void initState() {
    super.initState();
    namaC = TextEditingController(text: widget.laporan.namapelapor);
    judulC = TextEditingController(text: widget.laporan.judul);
    deskC = TextEditingController(text: widget.laporan.deskripsi);
    lokasiC = TextEditingController(text: widget.laporan.lokasi);

    jenisBencana = widget.laporan.jenisBencana;
    urgensi = widget.laporan.urgensi;
  }

  InputDecoration _input(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.teal),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.teal, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F6F6), // teal soft background
      appBar: AppBar(
        title: const Text("Edit Laporan"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaC,
                decoration: _input("Nama Pelapor"),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: jenisBencana,
                decoration: _input("Jenis Bencana"),
                dropdownColor: Colors.white,
                items: ["Banjir", "Gempa", "Kebakaran", "Tanah Longsor"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => jenisBencana = v,
              ),
              const SizedBox(height: 16),

              TextFormField(controller: judulC, decoration: _input("Judul")),
              const SizedBox(height: 16),

              TextFormField(
                controller: deskC,
                maxLines: 3,
                decoration: _input("Deskripsi"),
              ),
              const SizedBox(height: 16),

              TextFormField(controller: lokasiC, decoration: _input("Lokasi")),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                value: urgensi,
                decoration: _input("Urgensi"),
                dropdownColor: Colors.white,
                items: ["Rendah", "Sedang", "Tinggi"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => urgensi = v,
              ),
              const SizedBox(height: 30),

              // SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    final lap = LaporanFirebase(
                      id: widget.laporan.id,
                      namapelapor: namaC.text,
                      jenisBencana: jenisBencana!,
                      judul: judulC.text,
                      deskripsi: deskC.text,
                      lokasi: lokasiC.text,
                      urgensi: urgensi!,
                      tanggal: widget.laporan.tanggal,
                    );

                    await LaporanFirebaseService().updateLaporan(lap);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Simpan Perubahan",
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
}