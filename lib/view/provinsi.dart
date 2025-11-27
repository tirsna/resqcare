import 'package:flutter/material.dart';
import 'package:resqcare/theme/colors.dart';

import 'kota_page.dart';

class ProvinsiPage extends StatelessWidget {
  ProvinsiPage({super.key});

  final List<String> provinsiIndonesia = [
    "Aceh",
    "Sumatera Utara",
    "Sumatera Barat",
    "Riau",
    "Jambi",
    "Sumatera Selatan",
    "Bengkulu",
    "Lampung",
    "Kepulauan Bangka Belitung",
    "Kepulauan Riau",
    "DKI Jakarta",
    "Jawa Barat",
    "Jawa Tengah",
    "DI Yogyakarta",
    "Jawa Timur",
    "Banten",
    "Bali",
    "Nusa Tenggara Barat",
    "Nusa Tenggara Timur",
    "Kalimantan Barat",
    "Kalimantan Tengah",
    "Kalimantan Selatan",
    "Kalimantan Timur",
    "Kalimantan Utara",
    "Sulawesi Utara",
    "Sulawesi Tengah",
    "Sulawesi Selatan",
    "Sulawesi Tenggara",
    "Gorontalo",
    "Sulawesi Barat",
    "Maluku",
    "Maluku Utara",
    "Papua",
    "Papua Barat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Provinsi Indonesia"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: provinsiIndonesia.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.background,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: ListTile(
              title: Text(
                provinsiIndonesia[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KotaPage(provinsi: provinsiIndonesia[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
