import 'package:flutter/material.dart';
import 'package:resqcare/view/halamanutama.dart';
import 'package:resqcare/view/laporan.dart';
import 'package:resqcare/view/laporan_screen.dart';
import 'package:resqcare/view/maps.dart';
import 'package:resqcare/view/membuatlaporan.dart';
import 'package:resqcare/view/profail.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Halamanutama(),
    LaporanDaruratPage(),
    PetaZonaBahayaPage(),
    ProfilResqCarePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LaporanDaruratPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Beranda", 0),
              _buildNavItem(Icons.edit, "Laporan", 1),
              _buildNavItem(Icons.map, "Peta", 2),
              _buildNavItem(Icons.person, "Profil", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF183D3D) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black54,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
