import 'package:flutter/material.dart';
import 'package:resqcare/service/firebase/firebase_service.dart';

class HalamanPenyambut extends StatefulWidget {
  const HalamanPenyambut({
    super.key,
    required this.email,
    required this.nama,
    required this.kota,
  });

  final String email;
  final String nama;
  final String kota;

  @override
  State<HalamanPenyambut> createState() => _HalamanPenyambutState();
}

class _HalamanPenyambutState extends State<HalamanPenyambut> {
  final userService = FirebaseService();

  // Future<void> _onEdit(UserModel user) async {
  //   final editNameC = TextEditingController(text: user.username);
  //   final editEmailC = TextEditingController(text: user.email);
  //   final editCityC = TextEditingController(text: user.kota);
  //   final editHpC = TextEditingController(text: user.nohp.toString());

  //   final res = await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         title: const Text("Edit Data"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           spacing: 12,
  //           children: [
  //             BuildTextField(hinttext: "Name", controler: editNameC),
  //             BuildTextField(hinttext: "Email", controler: editEmailC),
  //             BuildTextField(hinttext: "City", controler: editCityC),
  //             BuildTextField(hinttext: "HP", controler: editHpC),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text("Batal"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () => Navigator.pop(context, true),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.green.shade700,
  //             ),
  //             child: const Text("Simpan"),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (res == true) {
  //     final updated = UserModel(
  //       id: user.id,
  //       username: editNameC.text,
  //       email: editEmailC.text,
  //       kota: editCityC.text,
  //       nohp: int.parse(editHpC.text),
  //     );

  //     await userService.updatePelapor(updated);
  //   }
  // }

  // Future<void> _onDelete(UserModel user) async {
  //   final res = await showDialog(
  //     context: context,
  //     builder: (_) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         title: const Text("Hapus Data"),
  //         content: Text(
  //           "Hapus data ${user.username}?",
  //           style: const TextStyle(fontSize: 16),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text("Tidak"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () => Navigator.pop(context, true),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.redAccent,
  //             ),
  //             child: const Text("Ya, hapus"),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (res == true) {
  //     await userService.deletePelapor(user.id!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 46, 28),
        title: Text(
          'Halo, ${widget.nama}!',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang ",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text("Berikut adalah informasi Anda:"),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama: ${widget.nama}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Email: ${widget.email}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Kota: ${widget.kota}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ========== STREAM BUILDER FIREBASE ==========
            // Expanded(
            //   child: StreamBuilder<List<UserModel>>(
            //     stream: userService.getAllPelapor(),
            //     builder: (context, snap) {
            //       if (!snap.hasData) {
            //         return const Center(child: CircularProgressIndicator());
            //       }

            //       final data = snap.data!;

            //       return ListView.builder(
            //         itemCount: data.length,
            //         itemBuilder: (_, i) {
            //           final u = data[i];
            //           return Container(
            //             margin: const EdgeInsets.symmetric(vertical: 8),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(16),
            //               boxShadow: const [
            //                 BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            //               ],
            //             ),
            //             child: ListTile(
            //               leading: CircleAvatar(
            //                 backgroundColor: Colors.green.shade200,
            //                 child: const Icon(Icons.person, color: Colors.white),
            //               ),
            //               title: Text(u.username ?? '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            //               subtitle: Text(u.email ?? ''),
            //               trailing: Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   IconButton(
            //                     onPressed: () => _onEdit(u),
            //                     icon: const Icon(Icons.edit, color: Colors.blueAccent),
            //                   ),
            //                   IconButton(
            //                     onPressed: () => _onDelete(u),
            //                     icon: const Icon(Icons.delete, color: Colors.redAccent),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
