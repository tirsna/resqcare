import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/models/user_model.dart';
import 'package:resqcare/view/sclingfigma.dart';
import 'package:resqcare/widgets/buildtextfield.dart';

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
  getData() {
    DbHelper.getAllPelapor();
    setState(() {});
  }

  Future<void> _onedit(UserModel user) async {
    final editNameC = TextEditingController(text: user.username);
    final editEmailC = TextEditingController(text: user.email);
    final editcityC = TextEditingController(text: user.kota);
    final editnoHPC = TextEditingController(text: user.nohp.toString());
    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Edit Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              BuildTextField(hinttext: "Name", controler: editNameC),
              BuildTextField(hinttext: "Email", controler: editEmailC),
              BuildTextField(hinttext: "City", controler: editcityC),
              BuildTextField(hinttext: "HP", controler: editnoHPC),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      final updated = UserModel(
        id: user.id,
        username: editNameC.text,
        email: editEmailC.text,
        nohp: int.parse(editnoHPC.text),
        kota: editcityC.text,
      );
      DbHelper.updatePelapor(updated);
      getData();
    }
  }

  Future<void> _onDelete(UserModel student) async {
    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Hapus Data"),
          content: Text(
            "Apakah anda yakin ingin menghapus data ${student.username}?",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Jangan"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Ya, hapus aja"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      DbHelper.deletePelapor(student.id!);
      getData();
    }
  }

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
              "Selamat Datang 🌿",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
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
                boxShadow: [
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

            // === DATA DARI DATABASE ===
            Expanded(
              child: FutureBuilder(
                future: DbHelper.getAllPelapor(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    final data = snapshot.data as List<UserModel>;
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final items = data[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green.shade200,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              items.username ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(items.email ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => _onedit(items),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _onDelete(items),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
