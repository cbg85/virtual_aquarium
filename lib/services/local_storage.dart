import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  Future<Database> _initializeDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'aquarium_settings.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE settings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            color TEXT,
            speed REAL
          )
        ''');
      },
      version: 1,
    );
  }

  Future<void> saveSettings(Color color, double speed) async {
    final db = await _initializeDb();
    await db.insert(
      'settings',
      {'color': color.value.toString(), 'speed': speed},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> loadSettings() async {
    final db = await _initializeDb();
    return await db.query('settings');
  }
}
