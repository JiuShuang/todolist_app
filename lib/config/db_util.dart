import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist_app/model/taskModel.dart';

class DBUtil{
  static late Database _database;
  static const int _version=1;
  static const String _databaseName="todolist.db";
  static late String _tableName;

  static Future<void> initDB(String tableName) async{
    _tableName=tableName;
    log("数据库初始化:$_tableName",time: DateTime.now());
    String path=join(await getDatabasesPath(),_databaseName);
    _database=await openDatabase(
      path, version: _version,
      onCreate: (db,version) {
          db.execute(
              "create table $_tableName("
                  "taskID integer primary key autoincrement,"
                  "taskTitle text,"
                  "taskNote text,"
                  "taskDate text,"
                  "startTime text,"
                  "endTime text,"
                  "remindTime text,"
                  "taskColors integer)"
          );
      }
    );

  }



  static Future<int> insert(TaskModel taskModel) async{
    log("添加数据:$taskModel",time: DateTime.now());
    return await _database.insert(_tableName, taskModel.toMap());
  }

  static Future queryByID(int taskID) async{
    log("查询数据:$taskID",time: DateTime.now());
   return await _database.query(_tableName,where: "taskID=?",whereArgs: [taskID]);
  }

  static Future queryAll() async{
    log("查询所有数据:$_database",time: DateTime.now());
    return await _database.query("task");
  }

  static Future deleteByID(int taskID) async{
    log("删除数据:$taskID",time: DateTime.now());
    return await _database.delete(_tableName,where: "taskID=?",whereArgs: [taskID]);
  }

  static Future updateByID(TaskModel taskModel) async{
    log("修改数据:$taskModel",time: DateTime.now());
    return await _database.update(_tableName,taskModel.toMap(),where: "taskID=?",whereArgs: [taskModel.taskID]);
  }

  static Future closeDB() async{
    log("关闭数据库",time: DateTime.now());
    await _database.close();
  }

}