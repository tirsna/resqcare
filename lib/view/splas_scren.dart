import 'package:flutter/material.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/view/bottomnav.dart';
// import 'package:resqcare/view/firebase/login_screen_firebase.dart';
// Tidak digunakan, tetapi dibiarkan jika sewaktu-waktu dibutuhkan.
import 'package:resqcare/view/login_screen.dart'
    as LoginView; // <-- DIPERBAIKI DENGAN ALIAS

class SplashScreenDay18 extends StatefulWidget {
  const SplashScreenDay18({super.key});

  @override
  State<SplashScreenDay18> createState() => _SplashScreenDay18State();
}

class _SplashScreenDay18State extends State<SplashScreenDay18>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Gerakan "ngusap ke atas"
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4), // mulai agak ke bawah
      end: Offset.zero, // berhenti di posisi normal
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Efek fade-in lembut
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Jalankan animasi
    _controller.forward();

    // Lanjut ke halaman berikutnya
    isLoginFunction();
  }

  isLoginFunction() async {
    // Memberikan jeda 3 detik sebelum navigasi
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      var isLogin = await PreferenceHandler.getLogin();
      if (isLogin != null && isLogin == true) {
        // Jika sudah login, pergi ke BottomNavExample
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavExample()),
          (route) => false,
        );
      } else {
        // Jika belum login, pergi ke LoginScreen
        Navigator.pushAndRemoveUntil(
          context,
          // Mengganti Loginresqcare() dengan class yang benar (diasumsikan LoginScreen)
          MaterialPageRoute(
            builder: (context) => const LoginView.Loginresqcare(),
          ), // <-- PERBAIKAN DI SINI
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Warna yang digunakan (0xFF0077B6) adalah warna Teal/Biru.
    const Color primaryColor = Color(0xFF0077B6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    height: 180,
                    width: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      // Catatan: Pastikan path aset ini benar
                      child: Image.asset(
                        'assets/images/resqcare.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Nama aplikasi
                  const Text(
                    "ResQcare",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: primaryColor,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subjudul
                  const Text(
                    "Siaga • Cepat • Tanggap",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Loading indicator
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
