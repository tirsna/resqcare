import 'package:flutter/material.dart';

class samsul extends StatefulWidget {
  const samsul({super.key});

  @override
  State<samsul> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<samsul> {
  bool trisna = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
          Text(
            trisna
                ? "lanjutkan pendaftarn diperbolehkan"
                : "anda belum bisa melanjautkan",
          ),
          ElevatedButton(
            onPressed: trisna ? () {} : null,
            child: Text(
              trisna
                  ? "saya metujui semua persyaratan yang berlaku"
                  : "maaf anda belum bisa melanjutkan",
            ),
          ),
        ],
      ),
    );
  }
}