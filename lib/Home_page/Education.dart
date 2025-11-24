import 'package:flutter/material.dart';
import 'package:resqcare/Home_page/detail_edukasi.dart';

class EdukasiPenangananPage extends StatefulWidget {
  const EdukasiPenangananPage({super.key});

  @override
  State<EdukasiPenangananPage> createState() => _EdukasiPenangananPageState();
}

class _EdukasiPenangananPageState extends State<EdukasiPenangananPage> {
  String selectedCategory = "Semua";

  // 🔹 Data edukasi per kategori (lebih lengkap)
  final Map<String, List<Map<String, String>>> edukasiData = {
    "Gempa Bumi": [
      {
        "title": "Saat Terjadi Gempa",
        "desc":
            "Segera lindungi kepala, cari tempat aman seperti di bawah meja kokoh, dan jauhi kaca serta benda berat yang tergantung.",
        "detail": """
1. Lindungi kepala dengan tas, bantal, atau tangan.
2. Berlindung di bawah meja yang kuat.
3. Hindari dekat jendela, lemari besar, atau benda gantung.
4. Tetap tenang dan tunggu hingga guncangan berhenti.
""",
      },
      {
        "title": "Setelah Gempa",
        "desc":
            "Periksa kondisi sekitar dan diri sendiri, bantu orang lain, serta keluar bangunan dengan hati-hati.",
        "detail": """
1. Matikan aliran listrik dan gas jika aman.
2. Periksa kondisi keluarga dan tetangga.
3. Hindari gedung retak atau area yang berpotensi roboh.
4. Siapkan diri untuk gempa susulan.
""",
      },
      {
        "title": "Persiapan Menghadapi Gempa",
        "desc":
            "Siapkan tas siaga berisi kebutuhan darurat dan kenali jalur evakuasi rumahmu.",
        "detail": """
1. Simpan dokumen penting dalam wadah tahan air.
2. Siapkan makanan ringan, air minum, dan senter.
3. Ketahui titik kumpul keluarga di area aman.
4. Latih simulasi evakuasi minimal 2x setahun.
""",
      },
    ],
    "Banjir": [
      {
        "title": "Saat Air Mulai Naik",
        "desc":
            "Amankan barang penting ke tempat tinggi, matikan listrik, dan siapkan perlengkapan darurat.",
        "detail": """
1. Amankan dokumen dan barang elektronik.
2. Putuskan aliran listrik & gas.
3. Siapkan tas siaga: air, makanan kering, obat-obatan.
4. Hubungi RT/RW bila air terus naik.
""",
      },
      {
        "title": "Ketika Banjir Melanda",
        "desc":
            "Hindari berjalan di air deras dan segera menuju tempat tinggi atau posko pengungsian.",
        "detail": """
1. Jangan nekat menyeberang arus deras.
2. Bantu anak-anak dan lansia lebih dulu.
3. Ikuti arahan petugas atau sirine evakuasi.
4. Bawa barang penting seperlunya saja.
""",
      },
      {
        "title": "Setelah Banjir Surut",
        "desc":
            "Bersihkan rumah dengan hati-hati dan pastikan listrik dalam kondisi aman sebelum dinyalakan.",
        "detail": """
1. Gunakan sarung tangan & sepatu saat membersihkan lumpur.
2. Hindari genangan karena bisa mengandung kuman.
3. Semprot disinfektan untuk mencegah penyakit.
4. Jangan nyalakan listrik sebelum dicek petugas PLN.
""",
      },
    ],
    "Kebakaran": [
      {
        "title": "Saat Kebakaran Terjadi",
        "desc":
            "Segera keluar melalui jalur evakuasi dan jangan gunakan lift. Lindungi hidung dengan kain basah.",
        "detail": """
1. Jangan panik, tetap tenang.
2. Gunakan tangga darurat, bukan lift.
3. Tutup hidung & mulut dengan kain basah.
4. Merangkak bila asap tebal.
""",
      },
      {
        "title": "Jika Pakaian Terbakar",
        "desc": "Gunakan metode STOP, DROP, dan ROLL untuk memadamkan api.",
        "detail": """
1. STOP — berhenti berlari.
2. DROP — jatuhkan diri ke lantai.
3. ROLL — berguling untuk memadamkan api.
4. Dinginkan luka bakar dengan air bersih.
""",
      },
      {
        "title": "Pencegahan Kebakaran di Rumah",
        "desc":
            "Periksa kabel dan gas secara berkala serta siapkan alat pemadam ringan di dapur.",
        "detail": """
1. Gunakan instalasi listrik ber-SNI.
2. Jangan menumpuk colokan listrik.
3. Simpan korek api jauh dari anak-anak.
4. Siapkan APAR kecil di dapur.
""",
      },
    ],
    "Tsunami": [
      {
        "title": "Segera Setelah Gempa",
        "desc":
            "Jika tinggal di daerah pantai, segera menuju tempat tinggi tanpa menunggu peringatan.",
        "detail": """
1. Setelah gempa kuat, segera menjauh dari pantai.
2. Hindari muara sungai atau tepi laut.
3. Bawa tas siaga & dokumen penting.
""",
      },
      {
        "title": "Saat Sirine Tsunami Berbunyi",
        "desc":
            "Ikuti jalur evakuasi resmi dan bantu orang sekitar untuk mencapai tempat aman.",
        "detail": """
1. Jangan gunakan kendaraan besar, bisa menimbulkan kemacetan.
2. Jalan kaki menuju bukit atau tempat tinggi.
3. Bantu anak-anak, lansia, dan penyandang disabilitas.
""",
      },
      {
        "title": "Setelah Tsunami",
        "desc":
            "Tunggu informasi resmi sebelum kembali ke rumah. Pastikan wilayah sudah aman.",
        "detail": """
1. Dengarkan berita dari sumber resmi (BMKG, BNPB).
2. Hindari air sisa tsunami karena bisa beracun.
3. Laporkan keberadaanmu ke posko atau petugas.
""",
      },
    ],
    "Longsor": [
      {
        "title": "Tanda-Tanda Longsor",
        "desc":
            "Waspadai retakan tanah, pohon miring, atau suara gemuruh dari lereng.",
        "detail": """
1. Waspadai retakan di tanah atau jalan.
2. Hindari aktivitas berat di lereng curam.
3. Segera evakuasi bila tanah mulai bergeser.
""",
      },
      {
        "title": "Saat Longsor Terjadi",
        "desc": "Segera menjauh dari arah longsoran dan cari tempat aman.",
        "detail": """
1. Segera lari ke arah berlawanan dari longsor.
2. Lindungi kepala dan leher.
3. Evakuasi ke area lapang yang aman.
""",
      },
      {
        "title": "Setelah Longsor",
        "desc":
            "Bantu evakuasi korban dengan hati-hati dan hindari area yang berpotensi longsor susulan.",
        "detail": """
1. Laporkan kejadian ke pihak berwenang.
2. Jangan dekati lereng curam.
3. Bersihkan jalur air yang tersumbat.
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

    final displayedItems = selectedCategory == "Semua"
        ? edukasiData.values.expand((list) => list).toList()
        : edukasiData[selectedCategory]!;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        elevation: 4,
        title: const Text(
          "Edukasi Penanganan Bencana",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.3),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pelajari panduan singkat dan mudah dipahami untuk menghadapi berbagai situasi darurat. Tetap tenang, waspada, dan selalu siap siaga.",
              style: TextStyle(
                fontSize: 15.5,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),

            // 🔹 Kategori
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((c) {
                  IconData icon = Icons.public;
                  Color color = Colors.teal;
                  switch (c) {
                    case "Gempa Bumi":
                      icon = Icons.vibration;
                      color = Colors.orange;
                      break;
                    case "Banjir":
                      icon = Icons.water_drop;
                      color = Colors.blue;
                      break;
                    case "Kebakaran":
                      icon = Icons.local_fire_department;
                      color = Colors.redAccent;
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

            const SizedBox(height: 22),

            // 🔹 Daftar Edukasi
            ...displayedItems.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
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

  // 🔸 Kategori chip
  Widget _buildCategoryChip(String label, IconData icon, Color color) {
    bool isSelected = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        avatar: Icon(icon, color: isSelected ? Colors.white : color, size: 18),
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedColor: color,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onSelected: (_) {
          setState(() {
            selectedCategory = label;
          });
        },
      ),
    );
  }

  // 🔸 Card edukasi
  Widget _buildEducationCard(
    String title,
    String description,
    String detailText,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.teal,
                ),
                label: const Text(
                  "Baca Selengkapnya",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
