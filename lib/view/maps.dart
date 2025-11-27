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
  Set<Polygon> _polygons = {};

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

      _loadZonaPoligon();
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // MAP
          Positioned.fill(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.teal),
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
                      ),
                    },
                    polygons: _polygons,
                    onMapCreated: (c) => mapController = c,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
          ),

          // BOTTOM SHEET
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.15,
            maxChildSize: 0.6,
            builder: (context, controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // drag indicator
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // TITLE
                    const Text(
                      "Peta Zona Bahaya",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // LIST KONTEN
                    Expanded(
                      child: ListView(
                        controller: controller,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
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
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // KARTU ZONA
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
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
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

  // POLIGON ZONA
  void _loadZonaPoligon() {
    _polygons = {
      Polygon(
        polygonId: const PolygonId("zona_kritis"),
        points: const [
          LatLng(-6.2015, 106.8225),
          LatLng(-6.2025, 106.8238),
          LatLng(-6.2032, 106.8215),
          LatLng(-6.2020, 106.8202),
        ],
        fillColor: Colors.redAccent.withOpacity(0.35),
        strokeColor: Colors.redAccent,
        strokeWidth: 3,
      ),

      Polygon(
        polygonId: const PolygonId("zona_waspada"),
        points: const [
          LatLng(-6.2040, 106.8250),
          LatLng(-6.2050, 106.8265),
          LatLng(-6.2060, 106.8248),
          LatLng(-6.2052, 106.8233),
        ],
        fillColor: Colors.orange.withOpacity(0.35),
        strokeColor: Colors.orange,
        strokeWidth: 3,
      ),

      Polygon(
        polygonId: const PolygonId("zona_aman"),
        points: const [
          LatLng(-6.2070, 106.8280),
          LatLng(-6.2080, 106.8295),
          LatLng(-6.2090, 106.8278),
          LatLng(-6.2082, 106.8263),
        ],
        fillColor: Colors.green.withOpacity(0.35),
        strokeColor: Colors.green,
        strokeWidth: 3,
      ),
    };

    setState(() {});
  }
}
