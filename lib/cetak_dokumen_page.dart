import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pelayanan_publik/status_model.dart';
import 'package:printing/printing.dart';

class CetakDokumenPage extends StatelessWidget {
  final StatusEntry entry;

  const CetakDokumenPage({super.key, required this.entry});

  static Future<Uint8List> _generatePdf(PdfPageFormat format, StatusEntry entry) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Bukti Pendaftaran',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Nama             : ${entry.nama}'),
              pw.Text('Layanan          : ${entry.layanan}'),
              pw.Text('Tanggal Daftar   : ${entry.tanggal}'),
              if (entry.tanggalEvent != null)
                pw.Text('Tanggal Acara    : ${entry.tanggalEvent}'),
              if (entry.agama != null) pw.Text('Agama            : ${entry.agama}'),
              pw.Text('Status           : ${entry.status}'),
              pw.SizedBox(height: 20),
              if (entry.files != null && entry.files!.isNotEmpty) ...[
                pw.Text('Dokumen yang diunggah:', style: pw.TextStyle(fontSize: 16)),
                pw.SizedBox(height: 10),
                for (var file in entry.files!.entries)
                  pw.Text('${file.key} : ${file.value.split('/').last}'),
              ],
              pw.SizedBox(height: 30),
              pw.Text('Terima kasih telah menggunakan layanan kami.'),
            ],
          ),
        ),
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cetak Dokumen'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: PdfPreview(
        build: (format) => _generatePdf(format, entry),
        canChangePageFormat: false,
        allowPrinting: true,
        allowSharing: true,
      ),
    );
  }
}
