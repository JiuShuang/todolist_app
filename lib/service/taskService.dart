import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/config/constant.dart';
import 'package:todolist_app/config/db_util.dart';
import 'package:todolist_app/controller/taskController.dart';
import 'package:todolist_app/model/taskModel.dart';
class TaskService{

  static Future getTasks() async{
    List<Map<String,dynamic>> tasks=await DBUtil.queryAll();
    TaskController.taskList.assignAll(tasks.map((e) => TaskModel.fromJson(e)).toList());
    print("taskService执行getTasks,时间为:${DateTime.now()}");
  }

 static Future addTask(TaskModel taskModel) async{
    return await DBUtil.insert(taskModel);
  }

  Future deleteTask(int taskID) async{
    return await DBUtil.deleteByID(taskID);
  }

  Future getTaskByID(int taskID) async{
    TaskModel taskModel=TaskModel.fromJson(await DBUtil.queryByID(taskID));
    return taskModel;
  }


}