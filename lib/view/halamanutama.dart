import 'package:flutter/material.dart';

class Halamanutama extends StatefulWidget {
  const Halamanutama({super.key});

  @override
  State<Halamanutama> createState() => _HalamanutamaState();
}

class _HalamanutamaState extends State<Halamanutama> {
  Widget buildActionCard(IconData icon, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 165, 126, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 12, 82, 39), size: 36),
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
      // backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white, Colors.green]),
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 1, 63, 7),
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
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(Icons.abc, size: 70),
                          ),
                          SizedBox(width: 15),
                          Column(
                            children: [
                              Text(
                                "ResQcare",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Eemergency Response System",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
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
                              ),
                            ),
                            Text(
                              "Aman - Jakarta Pusat",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.rocket_launch_sharp),
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
            ],
          ),
        ),
      ),
    );
  }
}
