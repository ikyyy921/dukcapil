
import 'package:flutter/material.dart';
import 'profile.dart';
import 'pernikanah.dart';
import 'kematian.dart';
import 'session.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beranda Pengguna"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Halo, ' + (Session.displayName ?? 'Pengguna') , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FormPernikahanPage())),
              icon: const Icon(Icons.favorite),
              label: const Text('Daftar Akta Pernikahan'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FormKematianPage())),
              icon: const Icon(Icons.sentiment_dissatisfied),
              label: const Text('Daftar Akta Kematian'),
            ),
          ],
        ),
      ),
    );
  }
}
