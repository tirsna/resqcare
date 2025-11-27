import 'package:flutter/material.dart';

class TandaBencanaPage extends StatelessWidget {
  const TandaBencanaPage({super.key});

  // DATA TANPA LINK, DENGAN PENJELASAN PANJANG
  final List<Map<String, dynamic>> tandaBencana = const [
    {
      "title": "Tsunami",
      "signs": [
        "Gempa kuat di bawah laut",
        "Air laut mendadak menyurut jauh",
        "Suara gemuruh dari laut",
      ],
      "explanation":
          "Tsunami biasanya dipicu oleh gempa bawah laut besar, longsoran bawah laut, atau letusan gunung api. "
          "Salah satu tanda paling umum adalah air laut tiba-tiba surut drastis. Setelah tanda ini muncul, "
          "tsunami dapat datang dalam hitungan menit. Selain itu, warga sering melaporkan suara gemuruh mirip "
          "kereta api dari arah laut. Jika gempa terasa sangat kuat dan berlangsung lama, terutama di dekat pantai, "
          "segera menuju tempat tinggi tanpa menunggu sirine. Tsunami bisa datang dalam beberapa gelombang dan gelombang "
          "lanjutan bisa lebih besar dari yang pertama.",
      "sourceName": "BMKG & InaTEWS",
    },
    {
      "title": "Gempa bumi (potensi besar)",
      "signs": [
        "Guncangan lama dan sangat kuat",
        "Getaran seperti ayunan",
        "Suara gemuruh dari tanah",
      ],
      "explanation":
          "Gempa besar terjadi karena pelepasan energi dari patahan aktif. Semakin lama durasi guncangan, semakin besar "
          "energi yang dilepas. Kadang terasa seperti diayun atau terdengar suara dari dalam tanah. Setelah gempa besar, "
          "gempa susulan hampir selalu terjadi. Jika guncangan sangat kuat hingga membuat sulit berdiri, itu indikasi "
          "gempa besar. Tetap jauhi bangunan tua, jendela, tiang listrik, dan ikuti instruksi resmi dari BMKG.",
      "sourceName": "USGS & BMKG",
    },
    {
      "title": "Tanah longsor",
      "signs": [
        "Hujan deras sangat lama",
        "Retakan tanah muncul",
        "Tiang/pohon mulai miring",
      ],
      "explanation":
          "Longsor dipicu oleh tanah jenuh air. Tanda-tandanya dapat berupa retakan baru di tanah, dinding mulai retak, "
          "atau suara batu jatuh pelan dari lereng. Jika setelah hujan ekstrem muncul retakan panjang atau pohon terlihat "
          "miring, itu tanda area mulai bergerak. Segera menjauh dari lereng karena longsor bisa terjadi tanpa suara besar.",
      "sourceName": "BNPB",
    },
    {
      "title": "Banjir & banjir bandang",
      "signs": [
        "Hujan deras di wilayah hulu",
        "Air sungai keruh & naik cepat",
        "Air masuk ke area tidak biasa",
      ],
      "explanation":
          "Banjir terjadi ketika curah hujan melebihi kapasitas drainase. Jika air sungai keruh dan naik cepat, itu tanda "
          "kiriman dari hulu. Banjir bandang jauh lebih berbahaya karena terjadi sangat cepat dan membawa material berat "
          "seperti kayu atau batu. Segera naik ke tempat tinggi jika air mulai meninggi dalam waktu singkat.",
      "sourceName": "BNPB",
    },
    {
      "title": "Letusan gunung berapi",
      "signs": [
        "Gempa vulkanik kecil berulang",
        "Gas/abu keluar meningkat",
        "Permukaan tanah mengembang",
      ],
      "explanation":
          "Gunung api menunjukkan tanda sebelum meletus: peningkatan gempa kecil, suara dentuman, perubahan warna asap, "
          "dan pengembangan permukaan gunung. Jika status gunung naik dari Level II ke III atau IV, penduduk harus mengikuti "
          "arah evakuasi. Arah angin juga penting karena menentukan penyebaran abu.",
      "sourceName": "PVMBG",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          "Tanda & Ciri Potensi Bencana",
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.teal),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.teal.shade100),
            ),
            child: const Text(
              "⚠️ Catatan: Informasi ini bersumber dari BMKG, BNPB, dan riset ilmiah internasional.",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          const SizedBox(height: 16),

          // CARD
          ...tandaBencana.map((item) => _buildCard(context, item)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> item) {
    final List<dynamic> signs = item['signs'] ?? [];
    final String explanation = item['explanation'] ?? "";
    final String shortText = explanation.length > 120
        ? "${explanation.substring(0, 120)}..."
        : explanation;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title'] ?? '-',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              "Tanda / Ciri:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            ...signs.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(child: Text(s.toString())),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "Penjelasan:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            Text(shortText, style: const TextStyle(fontSize: 13)),

            const SizedBox(height: 6),

            // BUTTON BACA SELENGKAPNYA
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => _showDetailPopup(context, item),
                child: const Text(
                  "Baca Selengkapnya",
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ),

            Row(
              children: [
                const Icon(Icons.info_outline, size: 14),
                const SizedBox(width: 6),
                Text(
                  "Sumber: ${item['sourceName']}",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // POPUP DETAIL
  void _showDetailPopup(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          item["title"],
          style: const TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            item["explanation"],
            style: const TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Tutup", style: TextStyle(color: Colors.teal)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
