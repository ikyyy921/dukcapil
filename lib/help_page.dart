import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Bantuan'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Pertanyaan Umum',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          _buildHelpItem(
            question: 'Bagaimana cara mendaftar akta perkawinan?',
            answer: 'Silakan buka menu Pendaftaran, pilih "Akta Perkawinan", lalu isi data dan unggah dokumen.',
          ),
          _buildHelpItem(
            question: 'Apa saja dokumen yang dibutuhkan?',
            answer: 'Setiap layanan memiliki dokumen berbeda. Pastikan Anda sudah menyiapkan KTP, KK, dan akta terkait.',
          ),
          _buildHelpItem(
            question: 'Kapan saya bisa melihat status pendaftaran?',
            answer: 'Setelah Anda mengirim formulir, status akan muncul di tab "Status".',
          ),
          _buildHelpItem(
            question: 'Apakah layanan ini tersedia 24 jam?',
            answer: 'Ya, layanan online tersedia 24 jam. Untuk pelayanan langsung, silakan datang ke kantor pada jam kerja.',
          ),

          const SizedBox(height: 30),
          const Divider(),
          const Text(
            'Butuh Bantuan Lebih Lanjut?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Hubungi kami di:'),
          const SizedBox(height: 5),
          Row(
            children: const [
              Icon(Icons.phone, size: 18, color: Colors.green),
              SizedBox(width: 8),
              Text('0711-123456'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: const [
              Icon(Icons.email, size: 18, color: Colors.green),
              SizedBox(width: 8),
              Text('dukcapil@palembang.go.id'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
