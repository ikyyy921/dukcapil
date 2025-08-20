import 'package:flutter/material.dart';
import 'package:pelayanan_publik/status_model.dart';
import 'cetak_dokumen_page.dart';

class DaftarPendaftaranPage extends StatefulWidget {
  const DaftarPendaftaranPage({super.key});

  // ✅ Data global disimpan di sini
  static final List<StatusEntry> _dataPendaftaran = [];

  // ✅ Method untuk menambahkan pendaftaran
  static void tambahPendaftaran(StatusEntry entry) {
    _dataPendaftaran.add(entry);
  }

  @override
  State<DaftarPendaftaranPage> createState() => _DaftarPendaftaranPageState();
}

class _DaftarPendaftaranPageState extends State<DaftarPendaftaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pendaftaran"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: DaftarPendaftaranPage._dataPendaftaran.isEmpty
          ? const Center(child: Text("Belum ada data pendaftaran"))
          : ListView.builder(
              itemCount: DaftarPendaftaranPage._dataPendaftaran.length,
              itemBuilder: (context, index) {
                final entry = DaftarPendaftaranPage._dataPendaftaran[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(entry.nama),
                    subtitle: Text("${entry.layanan} • ${entry.status}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.print, color: Colors.green),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CetakDokumenPage(entry: entry),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
