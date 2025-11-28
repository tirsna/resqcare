import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/firebase/profile_models.dart';
import '../../service/firebase/profile_service.dart';
import '../../theme/colors.dart';
import 'login_screen_firebase.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool _isEditing = false;

  String nama = "Pengguna ResqCare";
  String email = "";
  String bio = "Relawan aktif yang siap membantu kapan pun.";
  String daerahAman = "Bandung";

  late TextEditingController namaController;
  late TextEditingController bioController;
  late TextEditingController daerahController;

  final ProfileService _service = ProfileService();

  int totalReports = 0;
  int totalVerified = 0;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController();
    bioController = TextEditingController();
    daerahController = TextEditingController();
    email = FirebaseAuth.instance.currentUser?.email ?? "-";
    _loadProfile();
    _loadStats();
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final profile = await _service.getProfile(uid);
    if (!mounted) return;
    setState(() {
      nama = profile.name;
      bio = profile.bio;
      daerahAman = profile.daerahAman;

      namaController.text = nama;
      bioController.text = bio;
      daerahController.text = daerahAman;
    });
  }

  Future<void> _saveProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final profile = ProfileModel(
      uid: uid,
      name: namaController.text,
      email: email,
      bio: bioController.text,
      daerahAman: daerahController.text,
    );
    await _service.updateProfile(profile);
    setState(() {
      nama = namaController.text;
      bio = bioController.text;
      daerahAman = daerahController.text;
    });
  }

  Future<void> _loadStats() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final stats = await _service.getUserStats(uid);
    if (!mounted) return;
    setState(() {
      totalReports = stats["totalReports"] ?? 0;
      totalVerified = stats["totalVerified"] ?? 0;
    });
  }

  Widget _badgeKontributor(bool aktif) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        gradient: aktif
            ? LinearGradient(colors: [Colors.orange, Colors.red])
            : LinearGradient(colors: [Colors.white24, Colors.white12]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: aktif
            ? [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            color: Colors.white,
            size: aktif ? 24 : 16,
          ),
          SizedBox(width: 6),
          Text(
            aktif ? "Kontributor Legend 🔥" : "Kontributor Biasa",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    bool aktif = totalVerified >= 600;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF008080), Color.fromARGB(255, 1, 128, 106)],
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
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 48, color: Colors.teal[900]),
          ),
          SizedBox(height: 12),
          Text(
            nama,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(email, style: TextStyle(color: Colors.white70)),
          SizedBox(height: 14),
          _badgeKontributor(aktif),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
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
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 15, color: Colors.black87),
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
          Icon(icon, color: Colors.teal),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: TextStyle(
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
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Loginresqcare()),
        );
      },
      icon: Icon(Icons.logout),
      label: Text("Keluar Akun"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF008080),
        title: Text(
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
              if (_isEditing) await _saveProfile();
              setState(() => _isEditing = !_isEditing);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 24),
            _buildSectionCard(
              title: "Informasi Pribadi",
              child: Column(
                children: [
                  _isEditing
                      ? _editField("Nama Lengkap", namaController)
                      : _textItem("Nama", nama),
                  SizedBox(height: 10),
                  _isEditing
                      ? _editField("Bio", bioController, maxLines: 2)
                      : _textItem("Bio", bio),
                  SizedBox(height: 10),
                  _isEditing
                      ? _editField("Daerah Aman", daerahController)
                      : _textItem("Daerah Aman", daerahAman),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionCard(
              title: "Statistik Kontribusi",
              child: Column(
                children: [
                  _buildStatItem(
                    Icons.article,
                    "Total Laporan",
                    "$totalReports",
                  ),
                  _buildStatItem(
                    Icons.verified,
                    "Terverifikasi",
                    "$totalVerified",
                  ),
                  _buildStatItem(
                    Icons.local_fire_department,
                    "Level Kontributor",
                    totalVerified >= 600 ? "Legend 🔥" : "Pemula",
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            _logoutButton(context),
          ],
        ),
      ),
    );
  }
}
