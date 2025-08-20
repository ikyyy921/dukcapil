
import 'package:flutter/material.dart';

class PrintPage extends StatelessWidget {
  final String collection;
  final Map<String, dynamic> data;

  const PrintPage({super.key, required this.collection, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Siap Cetak')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jenis: ' + collection.replaceAll('_',' '), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...data.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Integrasikan dengan package pdf/printing jika diperlukan
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur cetak dapat diintegrasikan dengan package pdf/printing')));
                },
                child: const Text('Cetak / Simpan PDF'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
