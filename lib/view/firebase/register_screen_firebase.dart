// File: lib/view/register_screen.dart

import 'package:firebase_auth/firebase_auth.dart'; // Tetap dipertahankan untuk tipe error
import 'package:flutter/material.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/service/firebase/firebase_service.dart';
import 'package:resqcare/view/firebase/login_screen_firebase.dart';
import 'package:resqcare/view/penyambut.dart';

class DaftarResqcare extends StatefulWidget {
  const DaftarResqcare({super.key});

  @override
  State<DaftarResqcare> createState() => _DaftarResqcareState();
}

class _DaftarResqcareState extends State<DaftarResqcare> {
  final TextEditingController namacontroler = TextEditingController();
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController kota = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final fromkey = GlobalKey<FormState>();

  // State baru untuk tombol dan loading
  bool isbuttonenable = false;
  bool obscurepass = true;
  bool _isLoading = false; // <<< Tambahkan state loading

  @override
  void initState() {
    super.initState();
    // Pengecekan input untuk mengaktifkan tombol (sudah baik)
    namacontroler.addListener(checkformfield);
    emailcontroler.addListener(checkformfield);
    kota.addListener(checkformfield);
    nohp.addListener(checkformfield);
    passwordController.addListener(checkformfield);
  }

  void checkformfield() {
    setState(() {
      isbuttonenable =
          namacontroler.text.isNotEmpty &&
          emailcontroler.text.isNotEmpty &&
          kota.text.isNotEmpty &&
          nohp.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    namacontroler.dispose();
    emailcontroler.dispose();
    kota.dispose();
    nohp.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ===========================================
  // FUNGSI REGISTRASI FIREBASE
  // ===========================================
  Future<void> _handleRegister() async {
    if (fromkey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Mulai loading
      });

      try {
        final String email = emailcontroler.text.trim();
        final String password = passwordController.text.trim();
        final String username = namacontroler.text.trim();

        // Memanggil fungsi registerUser dari FirebaseService
        // Ini akan membuat Auth User dan menyimpan profil di Firestore
        final userModel = await FirebaseService.registerUser(
          email: email,
          password: password,
          username: username,
        );

        // Jika registrasi berhasil (userModel tidak null, yang pasti terjadi jika tidak throw error)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pendaftaran berhasil ✅"),
            backgroundColor: Colors.green,
          ),
        );

        // Simpan status login dan navigasi
        // Catatan: Jika Anda ingin menyimpan nohp dan kota,
        // Anda harus memodifikasi UserFirebaseModel dan FirebaseService
        PreferenceHandler.saveLogin(true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginresqcare()),
        );
      } on FirebaseAuthException catch (e) {
        // Penanganan Error Khusus Firebase Auth
        String message = "Terjadi kesalahan saat pendaftaran.";
        if (e.code == 'email-already-in-use') {
          message = "Email sudah terdaftar. Silakan gunakan email lain.";
        } else if (e.code == 'weak-password') {
          message = "Password terlalu lemah.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
        );
      } catch (e) {
        // Penanganan Error Umum
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pendaftaran gagal. Cek koneksi Anda."),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hentikan loading
        });
      }
    }
  }
  // ===========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF014E2E),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Header Section (sama seperti kode Anda)
            Column(
              children: [
                Hero(
                  tag: 'logo',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/resqcare.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "ResQcare Registration",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),

            /// Form Container
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Form(
                key: fromkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Formulir Pendaftaran",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF014E2E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Semua _buildTextField sudah bagus, tidak perlu diubah
                    _buildTextField(
                      label: "Nama",
                      hint: "Masukkan nama anda",
                      controller: namacontroler,
                      validator: (value) =>
                          value!.isEmpty ? 'Nama wajib diisi' : null,
                    ),
                    _buildTextField(
                      label: "Email",
                      hint: "Masukkan email anda",
                      controller: emailcontroler,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        }
                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: "Password",
                      hint: "Masukkan password anda",
                      controller: passwordController,
                      obscure: obscurepass,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurepass ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade600,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurepass = !obscurepass;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 8) {
                          return 'Password minimal 8 karakter';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: "Nomor HP",
                      hint: "Masukkan nomor HP",
                      controller: nohp,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor HP wajib diisi';
                        }
                        final RegExp phoneRegExp = RegExp(
                          r'^(?:\+62|0)[0-9]{8,14}$',
                        );
                        if (!phoneRegExp.hasMatch(value)) {
                          return 'Format nomor HP tidak valid';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      label: "Kota",
                      hint: "Masukkan kota anda",
                      controller: kota,
                      validator: (value) =>
                          value!.isEmpty ? 'Kota wajib diisi' : null,
                    ),

                    const SizedBox(height: 30),

                    /// Button (Diperbaiki)
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        width: 200,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            if (isbuttonenable &&
                                !_isLoading) // Hanya tampilkan shadow jika aktif dan tidak loading
                              BoxShadow(
                                color: Colors.greenAccent.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              7,
                              85,
                              0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: isbuttonenable && !_isLoading ? 8 : 0,
                          ),
                          // Panggil fungsi _handleRegister
                          onPressed: (isbuttonenable && !_isLoading)
                              ? _handleRegister
                              : null,
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                ) // Tampilkan loading
                              : const Text(
                                  "Daftar Sekarang",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// Footer Section (kembali ke Login)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah punya akun?",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildTextField (sama seperti kode Anda, ditaruh di luar build)
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    // ... (Isi widget yang sama seperti kode Anda)
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            obscureText: obscure,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              filled: true,
              fillColor: Colors.grey.shade100,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
                borderSide: BorderSide(color: Color(0xFF014E2E), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
