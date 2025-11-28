import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import library http
import 'package:resqcare/Home_page/Education.dart';
import 'package:resqcare/Home_page/penyebab.dart';
import 'package:resqcare/view/Tanda_bencana.dart';
import 'package:resqcare/view/provinsi.dart';

// Definisi API Key dan Konstanta
const String apiKey = "9ba03d411942ca71ad4e27323c23cfb2"; // API Key dari user
const String defaultCity = "Jakarta"; // Kota default
const String apiUrl =
    "https://api.openweathermap.org/data/2.5/weather?q=$defaultCity&units=metric&appid=$apiKey";

// Definisi warna Teal, Putih, dan Hitam yang Konsisten
const Color primaryTeal = Color(0xFF008080); // Teal Utama
const Color lightTeal = Color(
  0xFFE0F7FA,
); // Teal Sangat Muda (White-ish background)
const Color primaryBlack = Color(0xFF1E1E1E); // Hitam untuk Teks/Ikon

class Halamanutama extends StatefulWidget {
  final String userName;
  final int totalReports;

  const Halamanutama({
    super.key,
    this.userName = "Firda",
    this.totalReports = 6,
  });

  @override
  State<Halamanutama> createState() => _HalamanutamaState();
}

class _HalamanutamaState extends State<Halamanutama> {
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _fetchWeather(); // Panggil fungsi fetching data saat widget dibuat
  }

  // --- FUNGSI FETCH DATA CUACA ---
  Future<void> _fetchWeather() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _weatherData = data;
          _isLoading = false;
        });
      } else {
        // Handle error API
        setState(() {
          _errorMessage =
              "Gagal memuat cuaca. Kode: ${response.statusCode}. Cek koneksi atau API Key.";
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle error koneksi
      setState(() {
        _errorMessage = "Gagal terhubung ke server cuaca.";
        _isLoading = false;
      });
      print(e);
    }
  }

  // Helper untuk mendapatkan waktu saat ini
  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }

  // Helper untuk mendapatkan ikon berdasarkan kode cuaca OpenWeatherMap
  IconData _getWeatherIcon(int condition) {
    if (condition < 300) {
      return Icons.flash_on; // Thunderstorm
    } else if (condition < 600) {
      return Icons.cloudy_snowing; // Drizzle/Rain
    } else if (condition < 700) {
      return Icons.snowing; // Snow
    } else if (condition < 800) {
      return Icons.foggy; // Atmosphere (Fog, Mist, etc.)
    } else if (condition == 800) {
      return Icons.wb_sunny_outlined; // Clear
    } else if (condition <= 804) {
      return Icons.cloud_outlined; // Clouds
    } else {
      return Icons.help_outline;
    }
  }

  void _navigateToPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  // 1. HEADER KUSTOM (Nama Aplikasi & Aksi Cepat)
  Widget _buildCustomHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nama Aplikasi (RESQCARE)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "RESQCARE",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: primaryTeal,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Pusat Informasi & Kesiapsiagaan Bencana",
                style: TextStyle(
                  color: primaryBlack.withOpacity(0.7),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. CARD CUACA (Sekarang Menggunakan Data API)
  Widget _buildWeatherCard({
    required String location,
    required double temperature,
    required String weatherStatus,
    required IconData weatherIcon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: lightTeal, // Card cuaca menggunakan Light Teal
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryTeal.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: primaryBlack.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Lokasi
          Text(
            "Cuaca di $location",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryBlack.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 10),

          // Row Cuaca Real-Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${temperature.toStringAsFixed(1)}°C", // Tampilkan 1 desimal
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: primaryTeal,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    weatherStatus,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryBlack.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    "Pembaruan terakhir ${_getCurrentTime()}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryBlack.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              Icon(weatherIcon, size: 60, color: primaryTeal),
            ],
          ),
        ],
      ),
    );
  }

  // 3. CARD Navigasi Utama (Indeks Risiko)
  // ... (Tidak ada perubahan pada bagian ini)
  Widget _buildNavigationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Informasi Area",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: primaryBlack,
            ),
          ),
          const SizedBox(height: 12),
          _buildSmallCard(
            title: "Indeks Risiko Provinsi",
            subtitle: "Cek tingkat kerawanan di tiap daerah.",
            icon: Icons.public_outlined,
            onTap: () => _navigateToPage(ProvinsiPage()),
          ),
        ],
      ),
    );
  }

  // Widget pendukung untuk card kecil (Indeks Risiko)
  Widget _buildSmallCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: lightTeal,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryTeal.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryTeal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: primaryBlack,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryBlack.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: primaryTeal,
            ),
          ],
        ),
      ),
    );
  }

  // 4. CAROUSEL/Horizontal Scroll untuk Edukasi
  // ... (Tidak ada perubahan pada bagian ini)
  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(
            "Panduan Kesiapsiagaan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: primaryBlack,
            ),
          ),
        ),
        SizedBox(
          height: 170,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              _buildEducationCard(
                title: "Penanganan Darurat",
                icon: Icons.health_and_safety_outlined,
                onTap: () => _navigateToPage(const EdukasiPenangananPage()),
              ),
              const SizedBox(width: 12),
              _buildEducationCard(
                title: "Tipe & Penyebab Bencana",
                icon: Icons.book_outlined,
                onTap: () => _navigateToPage(const PenyebabBencanaPage()),
              ),
              const SizedBox(width: 12),
              _buildEducationCard(
                title: "Tanda Bencana",
                icon: Icons.warning_amber_outlined,
                onTap: () => _navigateToPage(const TandaBencanaPage()),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ],
    );
  }

  // Widget pendukung untuk Education Card (Horizontal)
  Widget _buildEducationCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryTeal.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: primaryBlack.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: primaryTeal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: primaryBlack,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            const Text(
              "Pelajari lebih lanjut",
              style: TextStyle(
                fontSize: 12,
                color: primaryTeal,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- BUILD UTAMA ---

  @override
  Widget build(BuildContext context) {
    Widget weatherWidget;

    if (_isLoading) {
      // Tampilkan Loading
      weatherWidget = Container(
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: primaryTeal),
      );
    } else if (_errorMessage.isNotEmpty) {
      // Tampilkan Error
      weatherWidget = Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red),
        ),
        child: Text(
          "🚨 Error Cuaca: $_errorMessage",
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      // Data berhasil dimuat, tampilkan Card Cuaca
      final temp = _weatherData!['main']['temp'];
      final status = _weatherData!['weather'][0]['description'];
      final conditionCode = _weatherData!['weather'][0]['id'];

      weatherWidget = _buildWeatherCard(
        location: _weatherData!['name'] ?? defaultCity,
        temperature: temp.toDouble(),
        weatherStatus: status.toString().toUpperCase(),
        weatherIcon: _getWeatherIcon(conditionCode),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(child: SizedBox(height: 16)),

            _buildCustomHeader(),

            // Tampilkan Widget Cuaca berdasarkan status loading/error
            weatherWidget,

            _buildNavigationSection(),

            // Garis pemisah yang halus
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Divider(
                color: primaryBlack.withOpacity(0.1),
                thickness: 1,
              ),
            ),

            _buildEducationSection(),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
