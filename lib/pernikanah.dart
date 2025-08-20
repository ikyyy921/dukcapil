import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPernikahanPage extends StatefulWidget {
  @override
  _FormPernikahanPageState createState() => _FormPernikahanPageState();
}

class _FormPernikahanPageState extends State<FormPernikahanPage> {
  final _formKey = GlobalKey<FormState>();
  String namaSuami = '';
  String namaIstri = '';
  String tanggalNikah = '';

  Future<void> kirimKeFirebase() async {
    try {
      await FirebaseFirestore.instance.collection('akte_pernikahan').add({
        'nama_suami': namaSuami,
        'nama_istri': namaIstri,
        'tanggal_nikah': tanggalNikah,
        'created_at': Timestamp.now(),
        'verified': false,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Pernikahan Berhasil Disimpan")),
      );

      // Kosongkan form setelah dikirim
      _formKey.currentState!.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Akte Pernikahan")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nama Suami"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => namaSuami = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Nama Istri"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => namaIstri = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Tanggal Pernikahan (yyyy-mm-dd)"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => tanggalNikah = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Kirim"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    kirimKeFirebase(); // Panggil fungsi kirim
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
