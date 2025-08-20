import 'package:flutter/material.dart';
import 'package:pelayanan_publik/home_admin.dart';
import 'package:pelayanan_publik/home_page.dart';
import 'package:pelayanan_publik/login_page.dart';
import 'package:pelayanan_publik/pendaftaran.dart';
import 'package:pelayanan_publik/splash_screen.dart';
import 'package:pelayanan_publik/status_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dukcapil Palembang',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFEFF8EC),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/admin': (context) => const HomeAdminPage(),

        // ✅ Rute untuk halaman formulir pendaftaran jika dibutuhkan
        '/formulir': (context) => PendaftaranPage(
              onKirimToUser: (StatusEntry entry) {
                print("✅ USER");
                print("Nama           : ${entry.nama}");
                print("Layanan        : ${entry.layanan}");
                print("Tanggal Daftar : ${entry.tanggal}");
                print("Tanggal Event  : ${entry.tanggalEvent}");
                print("Agama          : ${entry.agama}");
                print("Status         : ${entry.status}");
              },
              onKirimToAdmin: (StatusEntry entry) {
                print("✅ ADMIN");
                print("Nama           : ${entry.nama}");
                print("Layanan        : ${entry.layanan}");
                print("Tanggal Daftar : ${entry.tanggal}");
                print("Tanggal Event  : ${entry.tanggalEvent}");
                print("Agama          : ${entry.agama}");
                print("Status         : ${entry.status}");
              },
            ),
      },
    );
  }
}
