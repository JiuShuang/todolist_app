import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/config/constant.dart';
import 'package:todolist_app/config/db_util.dart';
import 'package:todolist_app/model/taskModel.dart';
import 'package:todolist_app/service/taskService.dart';

class TaskController extends GetxController{


  static var taskList=RxList<TaskModel>([]);

  addTask(TaskModel taskModel) {
    String taskTitle=taskModel.taskTitle;
    Get.defaultDialog(
        title: "Add Task",
        titleStyle: titleTextStyle,
        middleText: "Are you sure you want to add this task ($taskTitle) ",
        middleTextStyle: const TextStyle(fontSize: 20),
        confirm: ElevatedButton(
            onPressed: (){
              TaskService.addTask(taskModel);
              getTasksList();
              Get.snackbar("Add Task", "Successfully added task");
              Get.offNamed("/TodoPage");
            },
            child: const Text("Yes",)
        ),
        cancel: ElevatedButton(
            onPressed: (){
              Get.back();
            },
            child: const Text("No")
        )
    );
  }

  getTasksList() async{
    await TaskService.getTasks();
    var todayTask=<TaskModel>[];
    var otherTask=<TaskModel>[];
    for(var item in TaskController.taskList){
      if(item.taskDate==DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()){
        todayTask.add(item);
      }
      otherTask.add(item);
    }
    print("taskController执行getTasksList,时间为:${DateTime.now()}");
    return [todayTask,otherTask];
  }


}