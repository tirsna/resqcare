import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resqcare/database/preference_handler.dart';
import 'package:resqcare/theme/colors.dart';
import 'package:resqcare/view/firebase/login_screen_firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resqcare/view/login_screen.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _isEditing = false;

  String nama = "Pengguna ResqCare";
  String email = "user@trisna.id";
  String bio = "Relawan aktif yang siap membantu kapan pun.";
  String daerahAman = "Bandung";
  String? imagePath;

  late TextEditingController namaController;
  late TextEditingController bioController;
  late TextEditingController daerahController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController();
    bioController = TextEditingController();
    daerahController = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      nama = prefs.getString('nama') ?? nama;
      bio = prefs.getString('bio') ?? bio;
      daerahAman = prefs.getString('daerahAman') ?? daerahAman;
      imagePath = prefs.getString('imagePath');

      namaController.text = nama;
      bioController.text = bio;
      daerahController.text = daerahAman;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', namaController.text);
    await prefs.setString('bio', bioController.text);
    await prefs.setString('daerahAman', daerahController.text);
    await prefs.setString('imagePath', imagePath ?? "");
  }

  /// ---------------------------
  /// PICK IMAGE FUNCTION (BARU)
  /// ---------------------------
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        imagePath = file.path;
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', imagePath!);
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    bioController.dispose();
    daerahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.title,
        title: const Text(
          "Profil ResqCare",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () async {
              if (_isEditing) {
                await _saveData();
                if (!mounted) return;
                setState(() {
                  nama = namaController.text;
                  bio = bioController.text;
                  daerahAman = daerahController.text;
                });
              }
              setState(() => _isEditing = !_isEditing);
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionCard(
              title: "Informasi Pribadi",
              child: Column(
                children: [
                  _isEditing
                      ? _editField("Nama Lengkap", namaController)
                      : _textItem("Nama", nama),
                  const SizedBox(height: 10),
                  _isEditing
                      ? _editField("Bio", bioController, maxLines: 2)
                      : _textItem("Bio", bio),
                  const SizedBox(height: 10),
                  _isEditing
                      ? _editField("Daerah Aman", daerahController)
                      : _textItem("Daerah Aman", daerahAman),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionCard(
              title: "Statistik Kontribusi",
              child: Column(
                children: [
                  _buildStatItem(Icons.article_outlined, "Laporan Biasa", "10"),
                  _buildStatItem(Icons.warning_amber, "Laporan Sedang", "6"),
                  _buildStatItem(Icons.report_problem, "Laporan Kritis", "8"),
                  _buildStatItem(Icons.verified, "Terverifikasi", "23"),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _logoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF26A69A), Color(0xFF004D40)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          GestureDetector(
            onTap: _isEditing ? _pickImage : null, // ← ganti foto
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white,
              backgroundImage: imagePath != null && imagePath!.isNotEmpty
                  ? FileImage(File(imagePath!))
                  : null,
              child: (imagePath == null || imagePath!.isEmpty)
                  ? const Icon(Icons.person, color: Color(0xFF004D40), size: 45)
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            nama,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            email,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Kontributor Aktif",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _textItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _editField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        PreferenceHandler.removeLogin();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Loginresqcare()),
        );
      },
      icon: const Icon(Icons.logout),
      label: const Text("Keluar Akun"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
