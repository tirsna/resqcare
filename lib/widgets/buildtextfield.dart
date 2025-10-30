import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.controler,
    required this.hinttext,
  });
  final controler;
  final hinttext;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controler,
      decoration: InputDecoration(
        hintText: hinttext,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
