import 'package:flutter/material.dart';

class PenyebabBencanaPage extends StatelessWidget {
  const PenyebabBencanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Penyebab Terjadinya Bencana",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            _PenyebabItem(
              emoji: "🌍",
              title: "Gempa Bumi",
              shortDesc:
                  "Gempa bumi terjadi karena pergeseran atau tumbukan antar lempeng bumi...",
              fullDesc:
                  "Gempa bumi terjadi karena pergeseran atau tumbukan antar lempeng bumi (tektonik) dan juga aktivitas gunung berapi (vulkanik). Energi besar yang dilepaskan dari bawah permukaan bumi menyebabkan getaran yang merambat hingga ke permukaan.\n\nPenyebab utama: pergerakan lempeng bumi, aktivitas vulkanik, dan patahan kerak bumi.",
            ),
            _PenyebabItem(
              emoji: "🌊",
              title: "Tsunami",
              shortDesc:
                  "Tsunami adalah gelombang laut raksasa akibat gangguan di dasar laut...",
              fullDesc:
                  "Tsunami adalah gelombang laut raksasa yang terjadi akibat gangguan di dasar laut, biasanya karena gempa bumi bawah laut, letusan gunung berapi di laut, atau longsor bawah laut.\n\nPenyebab utama: gempa bumi bawah laut, letusan gunung api bawah laut, atau pergeseran sedimen besar di dasar laut.",
            ),
            _PenyebabItem(
              emoji: "💧",
              title: "Banjir",
              shortDesc:
                  "Banjir terjadi saat volume air melebihi kapasitas aliran sungai...",
              fullDesc:
                  "Banjir terjadi saat volume air melebihi kapasitas aliran sungai, drainase, atau tanah untuk menyerap air. Hal ini sering diperparah oleh curah hujan tinggi dan perilaku manusia yang mengabaikan lingkungan.\n\nPenyebab utama: hujan deras, saluran air tersumbat, penggundulan hutan, dan pembangunan di daerah resapan air.",
            ),
            _PenyebabItem(
              emoji: "🏔️",
              title: "Tanah Longsor",
              shortDesc:
                  "Tanah longsor adalah pergerakan massa tanah dari tempat tinggi ke bawah...",
              fullDesc:
                  "Tanah longsor adalah pergerakan massa tanah dan batuan dari tempat tinggi ke bawah karena gaya gravitasi. Biasanya terjadi di daerah perbukitan atau pegunungan saat tanah menjadi jenuh air.\n\nPenyebab utama: hujan deras, penggundulan hutan, struktur tanah yang labil, dan aktivitas manusia di lereng curam.",
            ),
            _PenyebabItem(
              emoji: "🔥",
              title: "Kebakaran Hutan atau Permukiman",
              shortDesc:
                  "Kebakaran dapat disebabkan oleh kelalaian manusia atau cuaca panas ekstrem...",
              fullDesc:
                  "Kebakaran dapat disebabkan oleh kelalaian manusia, faktor alam seperti cuaca panas ekstrem, atau percikan api kecil yang tidak segera dipadamkan. Di hutan, kebakaran bisa meluas sangat cepat karena daun kering dan angin.\n\nPenyebab utama: kelalaian manusia (membuang puntung rokok, pembakaran lahan), arus pendek listrik, dan suhu tinggi.",
            ),
            _PenyebabItem(
              emoji: "🌪️",
              title: "Angin Puting Beliung / Topan",
              shortDesc:
                  "Fenomena pusaran angin kencang akibat perbedaan tekanan udara ekstrem...",
              fullDesc:
                  "Fenomena ini adalah pusaran angin kencang yang terbentuk karena perbedaan tekanan udara ekstrem. Biasanya disertai hujan deras dan kilat, serta dapat menumbangkan bangunan ringan.\n\nPenyebab utama: perbedaan suhu dan tekanan udara yang tajam antara dua wilayah.",
            ),
            _PenyebabItem(
              emoji: "🌋",
              title: "Letusan Gunung Berapi",
              shortDesc:
                  "Terjadi ketika tekanan gas dan magma di dalam bumi meningkat...",
              fullDesc:
                  "Terjadi ketika tekanan gas dan magma di dalam bumi meningkat hingga akhirnya keluar melalui kawah gunung. Letusan bisa menyebabkan hujan abu, aliran lava, dan lahar panas.\n\nPenyebab utama: penumpukan tekanan magma dan gas di bawah permukaan bumi.",
            ),
          ],
        ),
      ),
    );
  }
}

class _PenyebabItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String shortDesc;
  final String fullDesc;

  const _PenyebabItem({
    required this.emoji,
    required this.title,
    required this.shortDesc,
    required this.fullDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        shortDesc,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: SingleChildScrollView(
                        child: Text(
                          fullDesc,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            "Tutup",
                            style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Lihat Selengkapnya",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
