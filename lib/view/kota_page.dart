import 'package:flutter/material.dart';
import 'package:resqcare/theme/colors.dart';
import 'package:resqcare/view/detail%20_resiko.dart';

class KotaPage extends StatelessWidget {
  final String provinsi;

  KotaPage({required this.provinsi, super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy kota sementara
    final List<String> kotaList = [
      "Kota 1",
      "Kota 2",
      "Kota 3",
      "Kota 4",
      "Kota 5",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Kota di $provinsi"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: kotaList.length,
        itemBuilder: (context, index) {
          return Card(
            color: AppColors.background,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.location_city, color: Colors.teal),
              title: Text(
                kotaList[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailResikoPage(kota: kotaList[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
