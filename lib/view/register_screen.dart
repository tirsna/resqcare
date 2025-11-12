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
  final TextEditingController namacontroler = TextEditingController();
  final TextEditingController emailcontroler = TextEditingController();
  final TextEditingController kota = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final fromkey = GlobalKey<FormState>();
  bool isbuttonenable = false;
  bool obscurepass = true;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF014E2E),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // ===== Header Logo & Judul =====
            Column(
              children: [
                Image.asset('assets/images/resqcare.jpg', width: 100),
                const SizedBox(height: 12),
                const Text(
                  "ResQcare Registration",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),

            // ===== Card Form =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
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
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF014E2E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Input Field Generator
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
                          color: Colors.grey,
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

                    const SizedBox(height: 25),

                    // ===== Tombol Daftar =====
                    Center(
                      child: SizedBox(
                        width: 180,
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
                            elevation: 6,
                          ),
                          onPressed: isbuttonenable
                              ? () async {
                                  if (fromkey.currentState!.validate()) {
                                    PreferenceHandler.saveLogin(true);
                                    final user = UserModel(
                                      username: namacontroler.text,
                                      email: emailcontroler.text,
                                      password: passwordController.text,
                                      nohp: int.parse(nohp.text),
                                      kota: kota.text,
                                    );
                                    await DbHelper.registerUser(user);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Pendaftaran berhasil ✅"),
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
                                          "Masukkan semua data dengan benar ⚠️",
                                        ),
                                      ),
                                    );
                                  }
                                }
                              : null,
                          child: const Text(
                            "Daftar Sekarang",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ===== Tombol Sign In =====
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

  // 🔧 Widget pembantu untuk input field biar rapi
  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
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
              filled: true,
              fillColor: Colors.grey.shade100,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFF014E2E)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
