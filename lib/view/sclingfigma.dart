import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/models/user_model.dart';
import 'package:resqcare/view/register_screen.dart';
import 'package:resqcare/view/penyambut.dart';
import 'package:resqcare/view/sclingfigma.dart';
import 'package:resqcare/widgets/buildtextfield.dart';

class Sclingfigma extends StatefulWidget {
  const Sclingfigma({super.key});

  @override
  State<Sclingfigma> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Sclingfigma> {
  @override
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              // color: Color.fromARGB(255, 90, 90, 92),
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/green earth.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'GREEN EARTH!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please login to get full access from us',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Color.fromARGB(255, 12, 2, 2),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),

                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Masukan email anda',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'emil tidak boleh kosong';
                      }
                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(value)) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  Text(
                    'Password',
                    style: TextStyle(color: Color.fromARGB(255, 12, 0, 0)),
                  ),
                  SizedBox(height: 5),

                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      suffixIcon: Icon(Icons.visibility_off),
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
                  SizedBox(width: double.infinity, height: 23),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        final user = await DbHelper.loginUser(
                          email: email,
                          password: password,
                        );
                        if (user != null) {
                          PreferenceHandler.saveLogin(true);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              // Untuk memindahkan ke halaman tertuju
                              builder: (context) => HalamanPenyambut(
                                email: email,
                                nama: "",
                                kota: '',
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Login Berhasil")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email Atau Password Salah '),
                            ),
                          );
                        }
                      },

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 350),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(8),
                        ),
                        backgroundColor: const Color.fromARGB(255, 83, 25, 117),
                      ),
                      child: Text(
                        "login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 247, 247, 247),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w100,
                          fontSize: 17,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(width: 1),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DaftarResqcare(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // SizedBox(width: 23),
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 247, 245, 245),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Divider(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),

                  Row(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // margin: const EdgeInsets.only(top: 88, right: 48),
                          padding: const EdgeInsets.all(8),
                          width: 88,
                          height: 49,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 106, 106, 116),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            'assets/images/goggle.jpg',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // margin: const EdgeInsets.only(top: 88, right: 48),
                          padding: const EdgeInsets.all(8),
                          width: 88,
                          height: 49,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 106, 106, 116),
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset('assets/images/tweter.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // margin: const EdgeInsets.only(top: 88, right: 48),
                          padding: const EdgeInsets.all(9),
                          width: 88,
                          height: 49,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 106, 106, 116),
                            ),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Image.asset('assets/images/facebok.jpg'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
