import 'package:flutter/material.dart';
import 'package:pelayanan_publik/edit_profil_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _namaLengkap = "Nama Anda";
  String _email = "email@example.com";
  String _role = "User";

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaLengkap = prefs.getString('nama') ?? "Nama Anda";
      _email = prefs.getString('email') ?? "email@example.com";
      _role = prefs.getString('role') ?? "User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8EC),
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            const SizedBox(height: 20),

            const Text("Nama Lengkap", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_namaLengkap),
            const SizedBox(height: 10),

            const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_email),
            const SizedBox(height: 10),

            const Text("Role", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_role),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfilePage()),
                  );
                  if (result == true) {
                    _loadProfile(); // Perbarui setelah kembali
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Profil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
