import 'package:flutter/material.dart';

class FileUploadWidget extends StatefulWidget {
  final Function(Map<String, String>) onFilesSelected;

  const FileUploadWidget({super.key, required this.onFilesSelected});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  final Map<String, String> _files = {};

  void _addDummyFile() {
    // ini contoh dummy (belum pakai picker asli)
    setState(() {
      _files['ktp'] = 'ktp_dummy.pdf';
    });
    widget.onFilesSelected(_files);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton.icon(
          onPressed: _addDummyFile,
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload File"),
        ),
        const SizedBox(height: 10),
        ..._files.entries.map((e) => Text("${e.key}: ${e.value}")),
      ],
    );
  }
}
