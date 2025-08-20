import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormKematianPage extends StatefulWidget {
  @override
  _FormKematianPageState createState() => _FormKematianPageState();
}

class _FormKematianPageState extends State<FormKematianPage> {
  final _formKey = GlobalKey<FormState>();
  String namaAlmarhum = '';
  String nik = '';
  String tanggalWafat = '';

  Future<void> kirimKeFirebase() async {
    try {
      await FirebaseFirestore.instance.collection('akte_kematian').add({
        'nama_almarhum': namaAlmarhum,
        'nik': nik,
        'tanggal_wafat': tanggalWafat,
        'created_at': Timestamp.now(),
        'verified': false,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Kematian Berhasil Disimpan")),
      );

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
      appBar: AppBar(title: Text("Form Akte Kematian")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nama Almarhum/Almarhumah"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => namaAlmarhum = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "NIK"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => nik = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Tanggal Wafat (yyyy-mm-dd)"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                onSaved: (value) => tanggalWafat = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Kirim"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    kirimKeFirebase();
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
