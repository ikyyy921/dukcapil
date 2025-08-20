import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'status_model.dart';

class DataStorage {
  static const String _userKey = 'status_user';
  static const String _adminKey = 'status_admin';

  /// Simpan status ke penyimpanan User
  static Future<void> saveStatusUser(StatusEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_userKey) ?? [];
    data.add(jsonEncode(entry.toJson()));
    await prefs.setStringList(_userKey, data);
  }

  /// Simpan status ke penyimpanan Admin
  static Future<void> saveStatusAdmin(StatusEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_adminKey) ?? [];
    data.add(jsonEncode(entry.toJson()));
    await prefs.setStringList(_adminKey, data);
  }

  /// Load semua status User
  static Future<List<StatusEntry>> loadStatusUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_userKey) ?? [];
    return data.map((e) => StatusEntry.fromJson(jsonDecode(e))).toList();
  }

  /// Load semua status Admin
  static Future<List<StatusEntry>> loadStatusAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_adminKey) ?? [];
    return data.map((e) => StatusEntry.fromJson(jsonDecode(e))).toList();
  }
}
