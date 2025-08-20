import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

class PdfGenerator {
  static Future<void> generatePDF(Map<String, dynamic> pendaftar) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Bukti Pendaftaran", style: pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Text("ID: ${pendaftar['id']}"),
                pw.Text("Nama: ${pendaftar['nama']}"),
                pw.Text("Email: ${pendaftar['email']}"),
                pw.Text("Status: ${pendaftar['status']}"),
              ],
            ),
          );
        },
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final file = File("${outputDir.path}/bukti_${pendaftar['id']}.pdf");
    await file.writeAsBytes(await pdf.save());
  }
}
