import 'package:flutter/material.dart';
import 'package:resqcare/view/daftar_peringatan.dart';

class Halamanutama extends StatefulWidget {
  const Halamanutama({super.key});

  @override
  State<Halamanutama> createState() => _HalamanutamaState();
}

class _HalamanutamaState extends State<Halamanutama> {
  Widget buildActionCard(IconData icon, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF00695C), size: 36),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color.fromARGB(179, 0, 0, 0),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 237, 240, 240),
                Color.fromARGB(255, 195, 247, 247),
              ],
            ),
          ),
          padding: EdgeInsets.all(3),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00695C),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255,
                                ).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Image.asset(
                                'assets/images/ResQcare App Logo - Emblem Style.jpg',
                                width: 70,
                                height: 70,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              children: [
                                const Text(
                                  "ResQcare",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  "Emergency Response System",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 33),
                        Container(
                          height: 78,
                          width: 400,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(
                              255,
                              194,
                              194,
                              194,
                            ).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 12, height: 12),
                                Text(
                                  "Status Wilayah Anda",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  "Aman - Jakarta Pusat",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16)),
                Row(
                  children: [
                    Icon(Icons.rocket_launch_sharp),
                    SizedBox(width: 8),
                    Text(
                      "Aksi Cepat",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    buildActionCard(
                      Icons.report,
                      "Buat Laporan",
                      "Laporkan kejadian",
                    ),
                    buildActionCard(
                      Icons.sos_rounded,
                      "Darurat",
                      "Panggil bantuan",
                    ),
                    buildActionCard(
                      Icons.place_outlined,
                      "Lokasi Aman",
                      "Cari tempat aman",
                    ),
                    buildActionCard(
                      Icons.phone,
                      "Kontak Darurat",
                      "Hubungi tim rescue",
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.warning),
                    Text(
                      "Peringatan Aktif",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                SizedBox(child: DaftarPeringatan()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
