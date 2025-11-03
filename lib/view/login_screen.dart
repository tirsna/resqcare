import 'package:flutter/material.dart';

class Loginresqcare extends StatefulWidget {
  const Loginresqcare({super.key});

  @override
  State<Loginresqcare> createState() => _LoginresqcareState();
}

class _LoginresqcareState extends State<Loginresqcare> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool trisna = false;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 70, 53),
      body: Center(
        child: Container(
          height: 800,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 51, 3),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Icon(
                    Icons.airline_seat_legroom_reduced_rounded,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                ),
                Text(
                  "ResQcare",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 51, 3),
                  ),
                ),
                Text(
                  "Emergency Response Ststem",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(225, 2, 51, 3),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'masukan email anda di sini',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Password",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                SizedBox(height: 0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    hintText: 'Masukan Password anda',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: trisna,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          trisna = value!;
                        });
                      },
                    ),
                    Text("inggatkan saya"),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'atau masuk dengan',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      width: 80,
                      height: 49,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 66, 63, 66),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('assets/images/tweter.jpg'),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      width: 80,
                      height: 49,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 66, 63, 66),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('assets/images/facebok.jpg'),
                    ),
                    SizedBox(height: 100),
                    Container(
                      padding: EdgeInsets.all(2),
                      width: 80,
                      height: 49,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 66, 63, 66),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('assets/images/goggle.jpg'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('dont have account'),
                  const SizedBox(width: 1,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
