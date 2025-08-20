import 'package:flutter/material.dart';
import 'package:pelayanan_publik/help_page.dart';
import 'package:pelayanan_publik/login_page.dart';
import 'package:pelayanan_publik/privaci_policy_page.dart';
import 'package:pelayanan_publik/profile_page.dart';


class LainnyaPage extends StatelessWidget {
  const LainnyaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8EC),
      appBar: AppBar(
        title: const Text("Lainnya"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Menu Tambahan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          ListTile(
            leading: const Icon(Icons.person, color: Colors.green),
            title: const Text("Profil Pengguna"),
            subtitle: const Text("Lihat dan edit data pengguna"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.green),
            title: const Text("Tentang Aplikasi"),
            subtitle: const Text("Informasi layanan Dukcapil"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Pelayanan Publik Dukcapil",
                applicationVersion: "1.0.0",
                applicationLegalese: "© 2025 Kota Palembang",
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.help_outline, color: Colors.green),
            title: const Text("Pusat Bantuan"),
            subtitle: const Text("FAQ dan bantuan teknis"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.green),
            title: const Text("Kebijakan Privasi"),
            subtitle: const Text("Cara kami melindungi data Anda"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Keluar"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Berhasil keluar")));
            },
          ),
        ],
      ),
    );
  }
}
