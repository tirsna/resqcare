import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PetaZonaBahayaPage extends StatefulWidget {
  const PetaZonaBahayaPage({super.key});

  @override
  State<PetaZonaBahayaPage> createState() => _PetaZonaBahayaPageState();
}

class _PetaZonaBahayaPageState extends State<PetaZonaBahayaPage> {
  GoogleMapController? mapController;

  LatLng? posisiUser;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _ambilLokasi();
  }

  Future<void> _ambilLokasi() async {
    try {
      bool izin = await Geolocator.requestPermission().then(
        (v) =>
            v == LocationPermission.always ||
            v == LocationPermission.whileInUse,
      );

      if (!izin) {
        setState(() => loading = false);
        return;
      }

      Position pos = await Geolocator.getCurrentPosition();

      setState(() {
        posisiUser = LatLng(pos.latitude, pos.longitude);
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 HEADER ATAS
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00695C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Row(
                        children: [
                          Icon(
                            Icons.map_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Peta Zona Bahaya",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Monitoring real-time area rawan bencana",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 🔹 GOOGLE MAPS
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[300],
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 4),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                          )
                        : posisiUser == null
                        ? const Center(
                            child: Text(
                              "Lokasi tidak ditemukan",
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        : GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: posisiUser!,
                              zoom: 15,
                            ),
                            markers: {
                              Marker(
                                markerId: const MarkerId("lokasi_user"),
                                position: posisiUser!,
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure,
                                ),
                                infoWindow: const InfoWindow(
                                  title: "Lokasi Anda",
                                ),
                              ),
                            },
                            onMapCreated: (c) => mapController = c,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: false,
                          ),
                  ),
                ),

                const SizedBox(height: 28),

                Row(
                  children: const [
                    Icon(
                      Icons.legend_toggle_rounded,
                      color: Colors.teal,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Peta Zona Bahaya",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                _buildZonaCard(
                  title: "Zona Kritis",
                  description: "Evakuasi segera · Bahaya tinggi",
                  color: Colors.redAccent,
                  level: "LEVEL 5",
                ),
                _buildZonaCard(
                  title: "Zona Waspada",
                  description: "Siaga tinggi · Pantau perkembangan",
                  color: Colors.orangeAccent,
                  level: "LEVEL 3",
                ),
                _buildZonaCard(
                  title: "Zona Perhatian",
                  description: "Kondisi normal · Tetap waspada",
                  color: Colors.blueAccent,
                  level: "LEVEL 2",
                ),
                _buildZonaCard(
                  title: "Zona Aman",
                  description: "Area aman · Tidak ada ancaman",
                  color: Colors.green,
                  level: "LEVEL 1",
                ),

                const SizedBox(height: 40),

                // 🔹 Lokasi user (card kuning)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFD54F), Color(0xFFFFB74D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_rounded,
                            color: Colors.pinkAccent,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Lokasi Anda Saat Ini",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        posisiUser == null
                            ? "Tidak ditemukan"
                            : "Lat: ${posisiUser!.latitude}, Lng: ${posisiUser!.longitude}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Kartu zona
  Widget _buildZonaCard({
    required String title,
    required String description,
    required Color color,
    required String level,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 10, backgroundColor: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              level,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
