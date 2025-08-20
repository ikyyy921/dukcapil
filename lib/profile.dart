
import 'package:flutter/material.dart';
import 'session.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 28, child: Icon(Icons.person)),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Session.displayName ?? 'Pengguna', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(Session.email ?? '-', style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Peran'),
              subtitle: Text(Session.role ?? '-'),
            ),
            ListTile(
              leading: const Icon(Icons.fingerprint),
              title: const Text('UID'),
              subtitle: Text(Session.uid ?? '-'),
            ),
          ],
        ),
      ),
    );
  }
}
