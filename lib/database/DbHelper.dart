import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import '../main.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'moods.db'), onCreate: (db, version) {
      return db.execute('CREATE TABLE user_moods(id INTEGER PRIMARY KEY AUTOINCREMENT,datetime TEXT,date TEXT,'
          'mood_id INTEGER,mood TEXT, image TEXT,'
          'act_id TEXT,actimage TEXT,actname TEXT,'
          'note Text,tag_id INTEGER,tag Text,tagImage Text,voiceNote Text,photos Text)');
    }, version: 1);
  }

  static Future<int?> countMood(String table) async {
    final db = await DBHelper.database();
    await db.rawQuery('SELECT COUNT(*), user_moods.mood FROM $table WHERE user_moods.mood = "Loving"');
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    return count;
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    var res = await db.rawQuery("SELECT * FROM $table ORDER BY date DESC");
    return res.toList();
  }

  static Future<List<Map<String, dynamic>>> getFilterDateData(String table, String date1, String date2) async {
    final db = await DBHelper.database();

    var res = await db.rawQuery("SELECT * FROM $table WHERE datetime BETWEEN '$date2' AND '$date1' ORDER BY date DESC");
    return res.toList();
  }

  static Future<List<Map<String, dynamic>>> getFilterData(String table, String value) async {
    List<String> a = ['Happy', 'Sad'];
    List<String> a1 = ['angry', 'happy'];
    final db = await DBHelper.database();
    final placeholders = List.generate(50, (_) => "?").join(",");
    var result = await db.query("$table", where: 'mood IN ($placeholders) OR tag IN ($placeholders)', whereArgs: [a, a1]);

    return result.toList();
  }

  static Future<List<Map<String, Object?>>> getMoodTagData() async {
    final db = await DBHelper.database();
    return await db.rawQuery("SELECT tag,tagImage FROM user_moods ");
  }

  static Future<List<Map<String, Object?>>> getMoodTagSadData() async {
    final db = await DBHelper.database();
    return await db.rawQuery("SELECT act_id, actname,actimage FROM user_moods");
  }

  static Future<List<Map<String, Object?>>> getMoodActivityData() async {
    final db = await DBHelper.database();
    return await db.rawQuery("SELECT  * FROM user_moods WHERE mood = 'Happy'");
  }

  static Future<List<Map<String, Object?>>> getMoodActivityDataGrp() async {
    final db = await DBHelper.database();
    return await db.rawQuery("SELECT  * FROM user_moods ");
  }

  static Future<List<Map<String, Object?>>> getMoodActivitySadData1(int id) async {
    final db = await DBHelper.database();
    return await db.rawQuery("SELECT actname,actimage FROM user_moods WHERE act_id = $id");
  }

  static Future<List<Map<String, Object?>>> getMoodActivitySadData() async {
    final db = await DBHelper.database();
    return await db.rawQuery("SELECT actname,actimage FROM user_moods WHERE id = 'Sad'");
  }

  static Future<void> getMoodFilterData(int id, int actId, int tagId) async {
    bool? isActivity = false;
    bool? isTag = false;
    bool? isMood = false;
    healthStore.clearMoodFilter();

    for (int i = 0; i < healthStore.moodCheckList.length; i++) {
      if (healthStore.moodCheckList[i].moodId.toString() == id.toString()) {
        isMood = true;
      } else {
        isMood = false;
      }
      for (int j = 0; j < healthStore.moodCheckList[i].activityId!.length; j++) {
        if (healthStore.moodCheckList[i].activityId![j] == actId.toString()) {
          isActivity = true;
          break;
        } else {
          isActivity = false;
        }
      }

      for (int k = 0; k < healthStore.moodCheckList[i].tagId!.length; k++) {
        if (healthStore.moodCheckList[i].tagId![k] == tagId.toString()) {
          isTag = true;
          break;
        } else {
          isTag = false;
        }
      }

      if (isActivity == true || isTag == true || isMood == true) {
        healthStore.addFilterMood(healthStore.moodCheckList[i]);
        healthStore.mFilterMood.forEach((element) {});
      }
    }
  }

  static Future<void> delete(int datetime) async {
    final db = await DBHelper.database();
    await db.rawDelete('DELETE FROM user_moods WHERE id = ?', [datetime]);
  }

  static Future<void> update(String table, Map<String, Object> data, int datetime) async {
    final db = await DBHelper.database();
    await db.update(table, data, where: 'id = ?', whereArgs: [datetime]);
  }
}
