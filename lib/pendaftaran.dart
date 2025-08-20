import 'data_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pelayanan_publik/status_model.dart';
import 'daftar_pendaftaran_page.dart';

class PendaftaranPage extends StatefulWidget {
  final Function(StatusEntry) onKirimToUser;
  final Function(StatusEntry) onKirimToAdmin;

  const PendaftaranPage({
    super.key,
    required this.onKirimToUser,
    required this.onKirimToAdmin,
  });

  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  String _selectedLayanan = 'Akta Perkawinan';
  String _selectedAgama = 'Islam';
  final TextEditingController _namaController = TextEditingController();
  DateTime? _tanggalPerkawinan;
  DateTime? _tanggalKematian;

  // ✅ Simpan file upload
  final Map<String, String> _uploadedFiles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pendaftaran'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Jenis Layanan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedLayanan,
              items: const [
                DropdownMenuItem(
                  value: 'Akta Perkawinan',
                  child: Text('Akta Perkawinan'),
                ),
                DropdownMenuItem(
                  value: 'Akta Kematian',
                  child: Text('Akta Kematian'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedLayanan = value!;
                  _namaController.clear();
                });
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: _selectedLayanan == 'Akta Perkawinan'
                    ? 'Nama Suami & Istri'
                    : 'Nama Almarhum',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedLayanan == 'Akta Perkawinan') _buildFormPerkawinan(),
            if (_selectedLayanan == 'Akta Kematian') _buildFormKematian(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownAgama() {
    List<String> agamaList = [
      'Islam',
      'Kristen',
      'Katolik',
      'Hindu',
      'Buddha',
      'Konghucu',
      'Lainnya',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _selectedAgama,
        items: agamaList
            .map((agama) => DropdownMenuItem(
                  value: agama,
                  child: Text(agama),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedAgama = value!;
          });
        },
        decoration: const InputDecoration(
          labelText: "Agama",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDateSelected(pickedDate);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          child: Text(
            selectedDate != null
                ? "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"
                : "Pilih $label",
          ),
        ),
      ),
    );
  }

  Widget _buildUploadField(String label, {required Function(String) onFilePicked}) {
    String? fileName;
    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              Expanded(child: Text(fileName ?? label)),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      fileName = result.files.single.name;
                    });
                    onFilePicked(result.files.single.path!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("File terpilih: $fileName")),
                    );
                  }
                },
                child: const Text("Pilih File"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormPerkawinan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Formulir Akta Perkawinan",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildTextField("NIK Suami"),
        _buildTextField("Nama Istri"),
        _buildTextField("NIK Istri"),
        _buildDropdownAgama(),
        _buildDatePicker(
          label: "Tanggal Perkawinan",
          selectedDate: _tanggalPerkawinan,
          onDateSelected: (date) {
            setState(() {
              _tanggalPerkawinan = date;
            });
          },
        ),
        _buildUploadField("Upload KTP Suami", onFilePicked: (path) {
          _uploadedFiles["KTP Suami"] = path;
        }),
        _buildUploadField("Upload KTP Istri", onFilePicked: (path) {
          _uploadedFiles["KTP Istri"] = path;
        }),
        _buildUploadField("Upload Kartu Keluarga", onFilePicked: (path) {
          _uploadedFiles["Kartu Keluarga"] = path;
        }),
        _buildUploadField("Upload Akta Kelahiran", onFilePicked: (path) {
          _uploadedFiles["Akta Kelahiran"] = path;
        }),
        const SizedBox(height: 20),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildFormKematian() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Formulir Akta Kematian",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildTextField("NIK Almarhum"),
        _buildDatePicker(
          label: "Tanggal Kematian",
          selectedDate: _tanggalKematian,
          onDateSelected: (date) {
            setState(() {
              _tanggalKematian = date;
            });
          },
        ),
        _buildTextField("Tempat Kematian"),
        _buildDropdownAgama(),
        _buildUploadField("Upload KTP", onFilePicked: (path) {
          _uploadedFiles["KTP"] = path;
        }),
        _buildUploadField("Upload Surat Kematian", onFilePicked: (path) {
          _uploadedFiles["Surat Kematian"] = path;
        }),
        _buildUploadField("Upload Kartu Keluarga", onFilePicked: (path) {
          _uploadedFiles["Kartu Keluarga"] = path;
        }),
        const SizedBox(height: 20),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton.icon(
      onPressed: () {
        if (_namaController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Nama tidak boleh kosong")),
          );
          return;
        }

        String? tanggalEvent;
        if (_selectedLayanan == 'Akta Perkawinan') {
          if (_tanggalPerkawinan == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Tanggal perkawinan harus dipilih")),
            );
            return;
          }
          tanggalEvent =
              "${_tanggalPerkawinan!.year}-${_tanggalPerkawinan!.month.toString().padLeft(2, '0')}-${_tanggalPerkawinan!.day.toString().padLeft(2, '0')}";
        } else {
          if (_tanggalKematian == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Tanggal kematian harus dipilih")),
            );
            return;
          }
          tanggalEvent =
              "${_tanggalKematian!.year}-${_tanggalKematian!.month.toString().padLeft(2, '0')}-${_tanggalKematian!.day.toString().padLeft(2, '0')}";
        }

        final entry = StatusEntry(
          nama: _namaController.text,
          layanan: _selectedLayanan,
          tanggal: DateTime.now().toString().substring(0, 10),
          status: 'Menunggu Verifikasi',
          tanggalEvent: tanggalEvent,
          agama: _selectedAgama,
          files: Map.from(_uploadedFiles),
        );

        // ✅ Kirim ke User dan Admin
      widget.onKirimToUser(entry);
      widget.onKirimToAdmin(entry);

      onPressed: () async {
  await DataStorage.saveStatusUser(entry);
  await DataStorage.saveStatusAdmin(entry);
};

        DaftarPendaftaranPage.tambahPendaftaran(entry);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pendaftaran berhasil dikirim")),
        );

        _namaController.clear();
        _tanggalPerkawinan = null;
        _tanggalKematian = null;
        _uploadedFiles.clear();
      },
      icon: const Icon(Icons.send),
      label: const Text("Kirim Pendaftaran"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }
}
