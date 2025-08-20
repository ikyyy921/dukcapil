import 'package:flutter/material.dart';
import 'package:pelayanan_publik/status_model.dart';
import 'package:pelayanan_publik/data_storage.dart';

class StatusAdminPage extends StatefulWidget {
  const StatusAdminPage({super.key});

  @override
  _StatusAdminPageState createState() => _StatusAdminPageState();
}

class _StatusAdminPageState extends State<StatusAdminPage> {
  List<StatusEntry> statusList = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  /// ✅ baca data status yang masuk ke admin
  Future<void> readData() async {
    final data = await DataStorage.loadStatusAdmin();
    setState(() {
      statusList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Status Pendaftaran (Admin)")),
      body: statusList.isEmpty
          ? const Center(child: Text("Belum ada status dari user"))
          : ListView.builder(
              itemCount: statusList.length,
              itemBuilder: (context, index) {
                final item = statusList[index];
                return Card(
                  child: ListTile(
                    title: Text(item.nama),
                    subtitle: Text("${item.layanan} - ${item.status}"),
                    trailing: Text(item.tanggal),
                  ),
                );
              },
            ),
    );
  }
}
