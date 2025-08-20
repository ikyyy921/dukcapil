import 'package:flutter/material.dart';
import 'package:pelayanan_publik/lainnya_page.dart';
import 'package:pelayanan_publik/pendaftaran.dart';
import 'package:pelayanan_publik/status_model.dart';
import 'package:pelayanan_publik/status_page_user.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<StatusEntry> _riwayatUser = [];
  final List<StatusEntry> _dataUntukAdmin = []; // ✅ Tambahan data untuk admin

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _tambahStatusUntukUser(StatusEntry entry) {
    setState(() {
      _riwayatUser.add(entry);
      _selectedIndex = 2; // otomatis pindah ke tab Status
    });
  }

  void _tambahDataUntukAdmin(StatusEntry entry) {
    setState(() {
      _dataUntukAdmin.add(entry);
      // kamu bisa tampilkan juga di halaman admin nanti
    });
  }

  List<Widget> get _pages => [
        BerandaContent(
          onDaftarTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        PendaftaranPage(
          onKirimToUser: _tambahStatusUntukUser,
          onKirimToAdmin: _tambahDataUntukAdmin,
        ),
        const RiwayatStatusPage(),
        const LainnyaPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Pendaftaran'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_outline), label: 'Status'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Lainnya'),
        ],
      ),
    );
  }
}

// ======================== BERANDA ========================
class BerandaContent extends StatelessWidget {
  final VoidCallback onDaftarTap;

  const BerandaContent({super.key, required this.onDaftarTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/Logo.png', height: 80),
                    const SizedBox(width: 10),
                    const Text(
                      'Pelayanan Publik\nKOTA PALEMBANG',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Pendaftaran\nPerkawinan\nNon-Islam\nAkte Kematian',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onDaftarTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(
            'assets/bersama12.png',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
  