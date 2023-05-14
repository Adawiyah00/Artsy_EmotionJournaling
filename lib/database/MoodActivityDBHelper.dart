import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class MoodActivityDBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'moodsActivity.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE moods_activity(id INTEGER PRIMARY KEY AUTOINCREMENT,datetime TEXT,moodActivityName TEXT, moodActivityImage TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await MoodActivityDBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await MoodActivityDBHelper.database();
    var res = await db.rawQuery("SELECT * FROM $table");
    return res.toList();
  }

  static Future<List<Map<String, dynamic>>> getMoodTag(String table,String? id) async {
    final db = await MoodActivityDBHelper.database();
    var res = await db.rawQuery("SELECT * FROM $table WHERE id=$id");
    return res.toList();
  }

  static Future<void> delete(int id) async {
    final db = await MoodActivityDBHelper.database();
    await db.rawDelete('DELETE FROM moods_activity WHERE id = ?', [id]);
  }

  static Future<int?> countMood() async {
    final db = await MoodActivityDBHelper.database();
    await db.rawQuery('SELECT COUNT(*) FROM moods_activity');
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM moods_activity'));
    return count;
  }

  static Future<void> update(String table, Map<String, Object> data, int id) async {
    final db = await MoodActivityDBHelper.database();
    await db.update(table, data, where: 'id=?', whereArgs: [id]);
  }
}
