import 'package:flutter/material.dart';

class DataPenggunaPage extends StatelessWidget {
  const DataPenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pengguna'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: const Center(child: Text('Contoh halaman data pengguna')),
    );
  }
}
