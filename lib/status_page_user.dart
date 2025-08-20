import 'package:flutter/material.dart';
import 'package:pelayanan_publik/status_model.dart';
import 'package:pelayanan_publik/data_storage.dart';

class RiwayatStatusPage extends StatefulWidget {
  const RiwayatStatusPage({super.key});

  @override
  State<RiwayatStatusPage> createState() => _RiwayatStatusPageState();
}

class _RiwayatStatusPageState extends State<RiwayatStatusPage> {
  List<StatusEntry> riwayat = [];
  bool _isLoading = true; // indikator loading

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    try {
      final data = await DataStorage.loadStatusUser(); // ambil dari file JSON lokal
      setState(() {
        riwayat = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat data: $e")),
      );
    }
  }

  // 🔹 Tambahan: supaya halaman bisa refresh setelah kembali dari pendaftaran
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadRiwayat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Status"),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : riwayat.isEmpty
              ? const Center(child: Text("Belum ada pendaftaran"))
              : RefreshIndicator( // 🔹 Tambahan: biar bisa tarik ke bawah untuk reload
                  onRefresh: _loadRiwayat,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: riwayat.length,
                    itemBuilder: (context, index) {
                      final item = riwayat[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.assignment, color: Colors.green),
                          title: Text(item.layanan),
                          subtitle: Text(
                            "Nama: ${item.nama}\nTanggal: ${item.tanggal}",
                          ),
                          trailing: Chip(
                            label: Text(item.status),
                            backgroundColor: item.status == "Sudah Diverifikasi"
                                ? Colors.green.shade100
                                : Colors.orange.shade100,
                            labelStyle: TextStyle(
                              color: item.status == "Sudah Diverifikasi"
                                  ? Colors.green.shade900
                                  : Colors.orange.shade900,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
