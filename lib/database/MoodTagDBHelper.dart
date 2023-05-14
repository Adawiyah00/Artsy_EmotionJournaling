import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class MooTagDBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'moodTag.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE mood_tag(id INTEGER PRIMARY KEY AUTOINCREMENT,datetime TEXT,moodTagName TEXT, moodTagImage TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await MooTagDBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await MooTagDBHelper.database();
    var res = await db.rawQuery("SELECT * FROM $table");
    return res.toList();
  }

  static Future<void> delete(int id) async {
    final db = await MooTagDBHelper.database();
    await db.rawDelete('DELETE FROM mood_tag WHERE id = ?', [id]);
  }

  static Future<int?> countMood(String table) async {
    final db = await MooTagDBHelper.database();
    await db.rawQuery('SELECT COUNT(*) FROM $table');
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    return count;
  }

  static Future<void> update(String table, Map<String, Object> data, int id) async {
    final db = await MooTagDBHelper.database();
    await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }
}
