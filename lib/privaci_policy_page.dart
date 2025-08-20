import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kebijakan Privasi'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Kebijakan Privasi',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            Text(
              '1. Informasi yang Dikumpulkan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Kami mengumpulkan informasi pribadi seperti nama, NIK, alamat, dokumen identitas, dan data lainnya yang Anda berikan saat menggunakan layanan pendaftaran.',
            ),
            SizedBox(height: 15),

            Text(
              '2. Penggunaan Informasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Informasi yang dikumpulkan digunakan untuk keperluan administrasi pelayanan publik, seperti verifikasi dokumen dan pembuatan akta.',
            ),
            SizedBox(height: 15),

            Text(
              '3. Keamanan Data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Kami menjaga data Anda dengan teknologi keamanan dan hanya dapat diakses oleh petugas resmi yang berwenang.',
            ),
            SizedBox(height: 15),

            Text(
              '4. Pembagian Informasi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Kami tidak membagikan data pribadi Anda kepada pihak ketiga tanpa izin, kecuali untuk kepentingan hukum atau peraturan pemerintah.',
            ),
            SizedBox(height: 15),

            Text(
              '5. Persetujuan Pengguna',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Dengan menggunakan aplikasi ini, Anda menyetujui pengumpulan dan penggunaan informasi sesuai dengan kebijakan ini.',
            ),
            SizedBox(height: 15),

            Text(
              '6. Perubahan Kebijakan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Kami dapat memperbarui kebijakan ini kapan saja. Perubahan akan diinformasikan melalui aplikasi.',
            ),
            SizedBox(height: 30),

            Text(
              'Hubungi Kami:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Jika Anda memiliki pertanyaan, silakan hubungi:'),
            Text('Email: dukcapil@palembang.go.id'),
            Text('Telepon: 0711-123456'),
          ],
        ),
      ),
    );
  }
}
