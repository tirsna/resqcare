import 'package:flutter/material.dart';
import 'package:resqcare/view/bottomnav.dart';
import 'package:resqcare/view/daftar_peringatan.dart';
import 'package:resqcare/view/danger_zonemaps.dart';
import 'package:resqcare/view/login_screen.dart';
// import 'package:ppkd_batch_4/checkbox.dart';
// import 'package:ppkd_batch_4/day18/daftarui.dart';
// import 'package:ppkd_batch_4/day19/splashscreen.dart';
import 'package:resqcare/view/main_screen.dart';
import 'package:resqcare/models/warning_models.dart';
// import 'package:ppkd_batch_4/tugas10.dart';

// import 'package:ppkd_batch_4/tester.dart';
// import 'package:ppkd_batch_4/tugas4.dart';
//import 'package:ppkd_batch_4/tugas2.dart';
// import 'package:ppkd_batch_4/tugas5.dart';
//import 'package:ppkd_batch_4/tugas5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: Loginresqcare(),
      
    );
  }
}
