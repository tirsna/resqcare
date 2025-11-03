import 'package:flutter/material.dart';
import 'package:resqcare/models/warning_models.dart';

class DaftarPeringatan extends StatefulWidget {
  const DaftarPeringatan({super.key});

  @override
  State<DaftarPeringatan> createState() => _DaftarPeringatanState();
}

class _DaftarPeringatanState extends State<DaftarPeringatan> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: daftarPeringatan.length, // jumlah data
      itemBuilder: (context, index) {
        final data = daftarPeringatan[index]; // ambil 1 data

        return Card(
          margin: const EdgeInsets.all(10),
          color: data.warnaStatus.withOpacity(0.1),
          child: ListTile(
            leading: Icon(data.icon, color: data.warnaStatus, size: 40),
            title: Text(
              data.judul,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${data.deskripsi}\nLokasi: ${data.lokasi}\nWaktu: ${data.waktu}",
            ),
            isThreeLine: true,
            trailing: Text(
              data.status,
              style: TextStyle(color: data.warnaStatus),
            ),
          ),
        );
      },
    );
  }
}
