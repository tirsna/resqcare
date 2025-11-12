import 'package:flutter/material.dart';
import 'package:resqcare/Home_page/detail_edukasi.dart';

class EdukasiPenangananPage extends StatefulWidget {
  const EdukasiPenangananPage({super.key});

  @override
  State<EdukasiPenangananPage> createState() => _EdukasiPenangananPageState();
}

class _EdukasiPenangananPageState extends State<EdukasiPenangananPage> {
  String selectedCategory = "Semua";

  // 🔹 Data edukasi per kategori
  final Map<String, List<Map<String, String>>> edukasiData = {
    "Gempa Bumi": [
      {
        "title": "Saat Terjadi Gempa",
        "desc":
            "Lindungi kepala, cari tempat aman seperti di bawah meja kokoh, dan jauhi kaca.",
        "detail": """
1. Lindungi kepala dengan tas atau bantal.
2. Berlindung di bawah meja atau struktur kokoh.
3. Hindari dekat jendela atau benda berat.
""",
      },
      {
        "title": "Setelah Gempa",
        "desc":
            "Periksa kondisi sekitar, bantu orang lain, dan evakuasi ke luar bangunan dengan hati-hati.",
        "detail": """
1. Matikan listrik dan gas bila memungkinkan.
2. Periksa orang di sekitarmu.
3. Siapkan diri menghadapi gempa susulan.
""",
      },
      {
        "title": "Persiapan Menghadapi Gempa",
        "desc":
            "Siapkan tas siaga berisi kebutuhan darurat dan kenali jalur evakuasi di rumahmu.",
        "detail": """
1. Simpan dokumen penting dalam wadah tahan air.
2. Ketahui titik kumpul evakuasi.
3. Latih simulasi evakuasi keluarga.
""",
      },
    ],
    "Banjir": [
      {
        "title": "Saat Air Mulai Naik",
        "desc": "Pindahkan barang ke tempat tinggi dan matikan listrik segera.",
        "detail": """
1. Amankan barang penting.
2. Putus aliran listrik dan gas.
3. Siapkan perlengkapan darurat.
""",
      },
      {
        "title": "Ketika Banjir Melanda",
        "desc":
            "Jangan berjalan di air deras, cari tempat tinggi atau atap aman.",
        "detail": """
1. Jangan nekat menyeberang air deras.
2. Evakuasi anak-anak dan lansia terlebih dahulu.
3. Ikuti arahan dari aparat setempat.
""",
      },
      {
        "title": "Setelah Banjir Surut",
        "desc":
            "Bersihkan rumah dengan hati-hati dan periksa instalasi listrik sebelum digunakan.",
        "detail": """
1. Gunakan sarung tangan dan sepatu.
2. Jangan nyalakan listrik sebelum diperiksa.
3. Semprot disinfektan untuk mencegah penyakit.
""",
      },
    ],
    "Kebakaran": [
      {
        "title": "Saat Kebakaran Terjadi",
        "desc": "Segera keluar lewat tangga darurat dan hindari lift.",
        "detail": """
1. Jangan panik, arahkan diri ke tangga darurat.
2. Gunakan kain basah untuk menutup hidung dan mulut.
3. Merangkak bila ada asap tebal.
""",
      },
      {
        "title": "Jika Pakaian Terbakar",
        "desc": "Gunakan metode Stop, Drop, and Roll.",
        "detail": """
1. STOP — berhenti berlari.
2. DROP — jatuhkan diri ke lantai.
3. ROLL — berguling untuk memadamkan api.
""",
      },
      {
        "title": "Pencegahan Kebakaran di Rumah",
        "desc":
            "Periksa instalasi listrik secara rutin dan simpan alat pemadam ringan.",
        "detail": """
1. Gunakan kabel ber-SNI.
2. Jangan menumpuk colokan listrik.
3. Siapkan APAR di area dapur.
""",
      },
    ],
    "Tsunami": [
      {
        "title": "Segera Setelah Gempa",
        "desc": "Segera menuju tempat tinggi jika berada di daerah pantai.",
        "detail": """
1. Jangan tunggu sirine, langsung evakuasi.
2. Hindari pantai dan muara sungai.
3. Bawa barang penting seperlunya.
""",
      },
      {
        "title": "Saat Sirine Tsunami Berbunyi",
        "desc": "Ikuti jalur evakuasi resmi dan bantu orang sekitar.",
        "detail": """
1. Jangan gunakan kendaraan besar.
2. Jalan kaki menuju tempat tinggi.
3. Bantu anak-anak dan lansia.
""",
      },
      {
        "title": "Setelah Tsunami",
        "desc": "Jangan kembali ke rumah sebelum ada pengumuman aman.",
        "detail": """
1. Dengarkan radio atau berita resmi.
2. Hindari genangan karena bisa mengandung bahan berbahaya.
3. Laporkan kondisi ke pihak berwenang.
""",
      },
    ],
    "Longsor": [
      {
        "title": "Tanda-Tanda Longsor",
        "desc": "Perhatikan retakan tanah dan suara gemuruh dari lereng.",
        "detail": """
1. Waspadai perubahan bentuk tanah.
2. Hindari tinggal di bawah tebing rawan.
3. Segera evakuasi jika tanda bahaya muncul.
""",
      },
      {
        "title": "Saat Longsor Terjadi",
        "desc":
            "Segera menjauh dari arah datangnya tanah dan cari tempat aman.",
        "detail": """
1. Jangan menunggu perintah jika sudah bahaya.
2. Lindungi kepala.
3. Evakuasi ke area lapang.
""",
      },
      {
        "title": "Setelah Longsor",
        "desc": "Bantu korban yang tertimbun dan laporkan ke petugas.",
        "detail": """
1. Jangan dekati lokasi longsor susulan.
2. Periksa jalur air dan saluran tersumbat.
3. Bantu evakuasi dengan hati-hati.
""",
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Semua",
      "Gempa Bumi",
      "Banjir",
      "Kebakaran",
      "Tsunami",
      "Longsor",
    ];

    // 🔹 Filter berdasarkan kategori
    final displayedItems = selectedCategory == "Semua"
        ? edukasiData.values.expand((list) => list).toList()
        : edukasiData[selectedCategory]!;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Edukasi Penanganan Bencana",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pelajari cara menghadapi situasi darurat agar selalu siap siaga.",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 16),

            // 🔹 Kategori
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((c) {
                  IconData icon = Icons.public;
                  Color color = Colors.teal;
                  switch (c) {
                    case "Gempa Bumi":
                      icon = Icons.public;
                      color = Colors.orange;
                      break;
                    case "Banjir":
                      icon = Icons.water;
                      color = Colors.blue;
                      break;
                    case "Kebakaran":
                      icon = Icons.local_fire_department;
                      color = Colors.red;
                      break;
                    case "Tsunami":
                      icon = Icons.waves;
                      color = Colors.cyan;
                      break;
                    case "Longsor":
                      icon = Icons.landscape;
                      color = Colors.brown;
                      break;
                  }
                  return _buildCategoryChip(c, icon, color);
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Daftar Edukasi
            ...displayedItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildEducationCard(
                  item["title"]!,
                  item["desc"]!,
                  item["detail"]!,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // 🔸 Widget kategori chip
  Widget _buildCategoryChip(String label, IconData icon, Color color) {
    bool isSelected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        avatar: Icon(icon, color: isSelected ? Colors.white : color, size: 18),
        label: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
        selected: isSelected,
        selectedColor: color,
        backgroundColor: Colors.white,
        onSelected: (_) {
          setState(() {
            selectedCategory = label;
          });
        },
      ),
    );
  }

  // 🔸 Widget card edukasi
  Widget _buildEducationCard(
    String title,
    String description,
    String detailText,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(color: Colors.black87, fontSize: 13),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EdukasiDetailPage(
                        title: title,
                        imagePath: '',
                        content: detailText,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Baca Selengkapnya →",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
