import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class KontakPentingPage extends StatelessWidget {
  const KontakPentingPage({super.key});

  final List<Map<String, dynamic>> kontakPenting = const [
    // Jakarta
    {
      "title": "BPBD DKI Jakarta",
      "number": "0211234567",
      "address": "Jl. Medan Merdeka Timur No. 10, Jakarta",
      "latitude": -6.1751,
      "longitude": 106.8272,
    },
    {
      "title": "Pemadam Kebakaran Jakarta Pusat",
      "number": "113",
      "address": "Jl. Tanah Abang No. 5, Jakarta",
      "latitude": -6.1911,
      "longitude": 106.8230,
    },
    // Bandung
    {
      "title": "BPBD Kota Bandung",
      "number": "0229876543",
      "address": "Jl. Wastukancana No. 2, Bandung",
      "latitude": -6.9147,
      "longitude": 107.6098,
    },
    {
      "title": "Dinas Pemadam Kebakaran Bandung",
      "number": "113",
      "address": "Jl. Braga No. 20, Bandung",
      "latitude": -6.9175,
      "longitude": 107.6191,
    },
    // Surabaya
    {
      "title": "BPBD Kota Surabaya",
      "number": "0317654321",
      "address": "Jl. Tunjungan No. 1, Surabaya",
      "latitude": -7.2575,
      "longitude": 112.7521,
    },
    {
      "title": "Dinas Pemadam Kebakaran Surabaya",
      "number": "113",
      "address": "Jl. Pemuda No. 12, Surabaya",
      "latitude": -7.2580,
      "longitude": 112.7470,
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
          "Kontak Penting",
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
              "⚠️ Catatan: Tombol Call & Maps sudah aktif, klik icon untuk mencoba.",
              style: TextStyle(color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20),
          ...kontakPenting.map((data) {
            return _buildContactCard(
              title: data['title'],
              number: data['number'],
              address: data['address'],
              latitude: data['latitude'],
              longitude: data['longitude'],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required String number,
    required String address,
    required double latitude,
    required double longitude,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
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
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.teal.shade400),
                const SizedBox(width: 10),
                Text(number, style: const TextStyle(fontSize: 14)),
                const Spacer(),
                _softIconButton(Icons.call, () {
                  _launchPhone(number);
                }),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red.shade300),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(address, style: const TextStyle(fontSize: 14)),
                ),
                _softIconButton(Icons.map, () {
                  _launchMaps(latitude, longitude);
                }),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Koordinat: ($latitude, $longitude)",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _softIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.teal.shade300),
      ),
    );
  }

  // Launch phone
  void _launchPhone(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch phone: $number");
    }
  }

  // Launch Google Maps
  void _launchMaps(double lat, double lng) async {
    final googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      debugPrint("Could not launch maps: $lat,$lng");
    }
  }
}
