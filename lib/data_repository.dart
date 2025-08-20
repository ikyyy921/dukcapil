import 'package:pelayanan_publik/status_model.dart';


/// Singleton penampung data pendaftaran di memori
class DataRepository {
  DataRepository._();
  static final DataRepository _instance = DataRepository._();
  factory DataRepository() => _instance;

  final List<StatusEntry> entries = [];

  void add(StatusEntry e) => entries.add(e);
  List<StatusEntry> get all => entries;
}
