import 'package:flutter/material.dart';
import 'package:resqcare/database/db_helper.dart';
import 'package:resqcare/database/latihan_splas.dart';
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
          title: Text("Edit Data"),
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
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Simpan"),
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
      // Fluttertoast.showToast(msg: "Data berhasil di update");
    }
  }

  Future<void> _onDelete(UserModel student) async {
    final res = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hapus Data"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Text(
                "Apakah anda yakin ingin menghapus data ${student.username}?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Jangan"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Ya, hapus aja"),
            ),
          ],
        );
      },
    );

    if (res == true) {
      DbHelper.deletePelapor(student.id!);
      getData();
      // Fluttertoast.showToast(msg: "Data berhasil di hapus");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halo ${widget.nama}')),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selamat Datang!", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 10),
            const Text("Berikut adalah informasi Anda:"),
            Text("Nama: ${widget.nama}"),
            Text("Email: ${widget.email}"),
            Text("Kota: ${widget.kota}"),
            FutureBuilder(
              future: DbHelper.getAllPelapor(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final data = snapshot.data as List<UserModel>;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final items = data[index];
                        return Column(
                          children: [
                            ListTile(
                              title: Text(items.username ?? ''),
                              subtitle: Text(items.email ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // _onEdit(items);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // _onDelete(items);
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                PreferenceHandler.removeLogin();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Sclingfigma()),
                  (route) => false,
                );
              },

              child: Text("Logout"),
            ),
            
          ],
        ),
      ),
    );
    
  }
  
}




