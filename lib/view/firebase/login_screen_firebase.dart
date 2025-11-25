import 'package:flutter/material.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/service/firebase/firebase_service.dart';
// Ganti import ini agar menunjuk ke file service yang sudah kita buat sebelumnya
import 'package:resqcare/view/bottomnav.dart';
import 'package:resqcare/view/firebase/register_screen_firebase.dart';

class Loginresqcare extends StatefulWidget {
  const Loginresqcare({super.key});

  @override
  State<Loginresqcare> createState() => _LoginresqcareState();
}

class _LoginresqcareState extends State<Loginresqcare> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool showPassword = false;
  bool _isLoading = false; // <<< TAMBAH STATE LOADING

  // Fungsi untuk menangani proses login
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Mulai loading
      });

      try {
        final firebaseUser = await FirebaseService.loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (firebaseUser != null) {
          // Login Berhasil
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Firebase berhasil!'),
              backgroundColor: Colors.green,
            ),
          );

          // Simpan status login
          if (rememberMe) {
             PreferenceHandler.saveLogin(true);
             // TODO: Simpan UID atau token jika diperlukan untuk auto-login berikutnya
          }

          // Navigasi
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavExample(),
            ),
          );
        } else {
          // Login Gagal (ditangkap dari error di service, misal: user-not-found)
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email atau password salah!'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        // Error umum (e.g., koneksi, server)
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Terjadi kesalahan: $e'),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004D40),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // LOGO
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF004D40),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      // Asumsi path asset sudah benar
                      child: Image.asset('assets/images/resqcare.jpg'), 
                    ),
                    const SizedBox(height: 10),

                    const Text(
                      "ResQcare",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF023303),
                      ),
                    ),
                    const Text(
                      "Emergency Response System",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // EMAIL FIELD
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Email", style: TextStyle(fontSize: 13)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Masukkan email anda di sini",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // PASSWORD FIELD
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Password", style: TextStyle(fontSize: 13)),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        hintText: "Masukkan password anda",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password wajib diisi';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // REMEMBER ME (Sudah benar)
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text("Ingatkan saya"),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // TOMBOL LOGIN (Diperbaiki untuk loading state)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        // Panggil fungsi _handleLogin
                        onPressed: _isLoading ? null : _handleLogin, 
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white) // Tampilkan loading
                            : const Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Pemisah
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'atau masuk dengan',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Ke Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Belum punya akun?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // Asumsi class Register Anda bernama DaftarResqcare
                                builder: (context) => const DaftarResqcare(), 
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}