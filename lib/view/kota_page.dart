import 'package:flutter/material.dart';
import 'package:resqcare/theme/colors.dart';
import 'package:resqcare/view/detail%20_resiko.dart';

class KotaPage extends StatelessWidget {
  final String provinsi;

  const KotaPage({required this.provinsi, super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> dataKota = {
      "Aceh": ["Banda Aceh", "Lhokseumawe", "Langsa", "Sabang", "Subulussalam"],
      "Sumatera Utara": [
        "Medan",
        "Binjai",
        "Tanjung Balai",
        "Pematang Siantar",
        "Sibolga",
      ],
      "Sumatera Barat": [
        "Padang",
        "Bukittinggi",
        "Payakumbuh",
        "Solok",
        "Sawahlunto",
      ],
      "Riau": ["Pekanbaru", "Dumai", "Bengkalis", "Siak", "Rengat"],
      "Jambi": [
        "Jambi",
        "Sungai Penuh",
        "Muaro Jambi",
        "Batanghari",
        "Tanjung Jabung Timur",
      ],
      "Sumatera Selatan": [
        "Palembang",
        "Lubuklinggau",
        "Pagar Alam",
        "Prabumulih",
        "Lahat",
      ],
      "Bengkulu": [
        "Bengkulu",
        "Rejang Lebong",
        "Bengkulu Utara",
        "Bengkulu Tengah",
        "Kaur",
      ],
      "Lampung": [
        "Bandar Lampung",
        "Metro",
        "Lampung Selatan",
        "Lampung Timur",
        "Lampung Tengah",
      ],
      "Kepulauan Bangka Belitung": [
        "Pangkal Pinang",
        "Bangka",
        "Belitung",
        "Bangka Tengah",
        "Bangka Barat",
      ],
      "Kepulauan Riau": [
        "Tanjung Pinang",
        "Batam",
        "Bintan",
        "Natuna",
        "Lingga",
      ],
      "DKI Jakarta": [
        "Jakarta Pusat",
        "Jakarta Selatan",
        "Jakarta Barat",
        "Jakarta Timur",
        "Jakarta Utara",
      ],
      "Jawa Barat": ["Bandung", "Bekasi", "Depok", "Bogor", "Cimahi"],
      "Jawa Tengah": [
        "Semarang",
        "Surakarta",
        "Magelang",
        "Purwokerto",
        "Pekalongan",
      ],
      "DI Yogyakarta": [
        "Yogyakarta",
        "Sleman",
        "Bantul",
        "Gunungkidul",
        "Kulon Progo",
      ],
      "Jawa Timur": ["Surabaya", "Malang", "Kediri", "Madiun", "Blitar"],
      "Banten": [
        "Serang",
        "Cilegon",
        "Tangerang",
        "Tangerang Selatan",
        "Pandeglang",
      ],
      "Bali": ["Denpasar", "Badung", "Tabanan", "Singaraja", "Karangasem"],
      "Nusa Tenggara Barat": [
        "Mataram",
        "Lombok Barat",
        "Lombok Tengah",
        "Lombok Timur",
        "Lombok Utara",
      ],
      "Nusa Tenggara Timur": [
        "Kupang",
        "Ende",
        "Maumere",
        "Larantuka",
        "Waingapu",
      ],
      "Kalimantan Barat": [
        "Pontianak",
        "Singkawang",
        "Ketapang",
        "Sintang",
        "Sambas",
      ],
      "Kalimantan Tengah": [
        "Palangka Raya",
        "Sampit",
        "Pulang Pisau",
        "Katingan",
        "Kuala Kapuas",
      ],
      "Kalimantan Selatan": [
        "Banjarmasin",
        "Banjarbaru",
        "Martapura",
        "Tanjung",
        "Amuntai",
      ],
      "Kalimantan Timur": [
        "Samarinda",
        "Balikpapan",
        "Bontang",
        "Tenggarong",
        "Sangatta",
      ],
      "Kalimantan Utara": [
        "Tanjung Selor",
        "Tarakan",
        "Nunukan",
        "Malinau",
        "Bulungan",
      ],
      "Sulawesi Utara": [
        "Manado",
        "Bitung",
        "Tomohon",
        "Kota Kotamobagu",
        "Minahasa",
      ],
      "Sulawesi Tengah": [
        "Palu",
        "Donggala",
        "Buol",
        "Morowali",
        "Parigi Moutong",
      ],
      "Sulawesi Selatan": [
        "Makassar",
        "Parepare",
        "Barru",
        "Bulukumba",
        "Bone",
      ],
      "Sulawesi Tenggara": [
        "Kendari",
        "Bau-Bau",
        "Kolaka",
        "Bombana",
        "Wakatobi",
      ],
      "Gorontalo": [
        "Gorontalo",
        "Boalemo",
        "Bone Bolango",
        "Pohuwato",
        "Banggai Kepulauan",
      ],
      "Sulawesi Barat": [
        "Mamuju",
        "Polewali Mandar",
        "Majene",
        "Mamasa",
        "Mamuju Tengah",
      ],
      "Maluku": ["Ambon", "Tual", "Banda", "Namlea", "Masohi"],
      "Maluku Utara": [
        "Ternate",
        "Tidore",
        "Sofifi",
        "Morotai",
        "Halmahera Selatan",
      ],
      "Papua": ["Jayapura", "Sentani", "Merauke", "Sorong", "Biak"],
      "Papua Barat": ["Manokwari", "Sorong", "Raja Ampat", "Fakfak", "Bintuni"],
    };

    final List<String> kotaList = dataKota[provinsi] ?? ["Kota A", "Kota B"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Kota di $provinsi"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: kotaList.length,
        itemBuilder: (context, index) {
          final kota = kotaList[index];

          return Card(
            color: AppColors.background,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.location_city, color: Colors.teal),
              title: Text(
                kota,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailResikoPage(kota: kota),
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
