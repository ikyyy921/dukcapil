import 'package:flutter/material.dart';
import 'status_model.dart';
import 'data_storage.dart';

class RiwayatStatusPage extends StatefulWidget {
  const RiwayatStatusPage({super.key});

  @override
  State<RiwayatStatusPage> createState() => _RiwayatStatusPageState();
}

class _RiwayatStatusPageState extends State<RiwayatStatusPage> {
  List<StatusEntry> riwayat = [];

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    final data = await DataStorage.loadStatusUser();
    setState(() {
      riwayat = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Status"),
        backgroundColor: Colors.green,
      ),
      body: riwayat.isEmpty
          ? const Center(child: Text("Belum ada pendaftaran"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                final item = riwayat[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.assignment, color: Colors.green),
                    title: Text(item.layanan),
                    subtitle:
                        Text("Nama: ${item.nama}\nTanggal: ${item.tanggal}"),
                    trailing: Chip(label: Text(item.status)),
                  ),
                );
              },
            ),
    );
  }
}
