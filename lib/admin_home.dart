
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'print_page.dart';
import 'profile.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
          ),
        ],
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(text: 'Akta Pernikahan'),
            Tab(text: 'Akta Kematian'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _buildList('akte_pernikahan', fields: const ['nama_suami','nama_istri','tanggal_nikah']),
          _buildList('akte_kematian', fields: const ['nama_almarhum','nik','tanggal_wafat']),
        ],
      ),
    );
  }

  Widget _buildList(String collection, {required List<String> fields}) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).orderBy('created_at', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Belum ada data'));
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final data = doc.data() as Map<String, dynamic>;
            final verified = data['verified'] == true;
            final subtitle = fields.map((f)=> '${f.replaceAll('_',' ').toUpperCase()}: ${data[f] ?? '-'}').join(' | ');
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                title: Text('${collection.replaceAll('_',' ').toUpperCase()} #${index+1}'),
                subtitle: Text(subtitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!verified)
                      TextButton(
                        onPressed: () async {
                          await doc.reference.update({'verified': true});
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data diverifikasi')));
                        },
                        child: const Text('Verifikasi'),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: verified ? () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => PrintPage(collection: collection, data: data),
                        ));
                      } : null,
                      child: const Text('Cetak'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
