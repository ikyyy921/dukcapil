class StatusEntry {
  final String nama;
  final String layanan;
  final String tanggal;
  final String status;
  final String? tanggalEvent;
  final String? agama;
  final Map<String, String>? files;

  // ✅ Tambahan: verifikasi admin
  final bool isVerified;

  StatusEntry({
    required this.nama,
    required this.layanan,
    required this.tanggal,
    required this.status,
    this.tanggalEvent,
    this.agama,
    this.files,
    this.isVerified = false, // default belum diverifikasi
  });

  // ✅ Baca dari JSON
  factory StatusEntry.fromJson(Map<String, dynamic> json) {
    // amankan konversi "files" ke Map<String, String>
    Map<String, String>? filesMap;
    final rawFiles = json['files'];
    if (rawFiles is Map) {
      filesMap = rawFiles.map(
        (k, v) => MapEntry(k.toString(), v?.toString() ?? ''),
      );
    }

    return StatusEntry(
      nama: json['nama']?.toString() ?? '',
      layanan: json['layanan']?.toString() ?? '',
      tanggal: json['tanggal']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      tanggalEvent: json['tanggalEvent']?.toString(),
      agama: json['agama']?.toString(),
      files: filesMap,
      isVerified: json['isVerified'] == true, // default false
    );
  }

  // ✅ Simpan ke JSON
  Map<String, dynamic> toJson() => {
        'nama': nama,
        'layanan': layanan,
        'tanggal': tanggal,
        'status': status,
        'tanggalEvent': tanggalEvent,
        'agama': agama,
        'files': files,
        'isVerified': isVerified,
      };
}
