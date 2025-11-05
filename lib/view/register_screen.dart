import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/models/user_model.dart';
import 'package:resqcare/view/penyambut.dart';

class DaftarResqcare extends StatefulWidget {
  const DaftarResqcare({super.key});

  @override
  State<DaftarResqcare> createState() => _DaftarResqcareState();
}

class _DaftarResqcareState extends State<DaftarResqcare> {
  // Controller untuk inputan teks
  final TextEditingController namacontroler = TextEditingController();
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController kota = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Key untuk validasi form
  final fromkey = GlobalKey<FormState>();

  // Variabel untuk atur tombol & password visibility
  bool isbuttonenable = false;
  bool obscurepass = true;

  @override
  void initState() {
    super.initState();

    // Cek perubahan setiap field supaya tombol aktif cuma kalau semua terisi
    namacontroler.addListener(checkformfield);
    emailcontroler.addListener(checkformfield);
    kota.addListener(checkformfield);
    nohp.addListener(checkformfield);
    passwordController.addListener(checkformfield);
  }

  // Fungsi untuk ngecek apakah semua form sudah terisi
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
    // Buat ngehapus controller dari memori biar gak bocor
    namacontroler.dispose();
    emailcontroler.dispose();
    kota.dispose();
    nohp.dispose();
    // emailcontroler.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 78, 46),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),

            // === KOTAK FORM PUTIH ===
            Container(
              width: 345,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // ===== NAMA =====
                    const Text("Nama"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: namacontroler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan nama anda",
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Nama wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 12),

                    // ===== EMAIL =====
                    const Text("Email"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: emailcontroler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan email anda",
                      ),
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
                    const SizedBox(height: 12),

                    // ===== PASSWORD =====
                    const Text("Password"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscurepass,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Masukkan password anda',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurepass = !obscurepass;
                            });
                          },
                          icon: Icon(
                            obscurepass
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
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
                    const SizedBox(height: 12),

                    // ===== NO HP =====
                    const Text("Nomor HP"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: nohp,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan nomor HP",
                      ),
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
                    const SizedBox(height: 12),

                    // ===== KOTA =====
                    const Text("Kota"),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: kota,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Masukkan kota anda",
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Kota wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 25),

                    // ===== TOMBOL DAFTAR =====
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 50,
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
                          ),
                          onPressed: isbuttonenable
                              ? () async {
                                  if (fromkey.currentState!.validate()) {
                                    // Simpan status login
                                    PreferenceHandler.saveLogin(true);

                                    // Simpan ke database
                                    final user = UserModel(
                                      username: namacontroler.text,
                                      email: emailcontroler.text,
                                      password: passwordController.text,
                                      nohp: int.parse(nohp.text),
                                      kota: kota.text,
                                    );
                                    await DbHelper.registerUser(user);

                                    // Tampilkan pesan & pindah halaman
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Pendaftaran berhasil"),
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HalamanPenyambut(
                                          email: emailcontroler.text,
                                          nama: namacontroler.text,
                                          kota: kota.text,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Masukkan semua data dengan benar",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: const Text(
                            "Daftar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== TOMBOL SIGN IN =====
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sudah punya akun?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "sing in",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
