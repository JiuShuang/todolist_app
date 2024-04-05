import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/config/constant.dart';
import 'package:todolist_app/model/taskModel.dart';
import 'package:todolist_app/service/taskService.dart';
import 'package:todolist_app/ui/todo_page.dart';

class TaskController extends GetxController{

  final todayTask=RxList<TaskModel>([]);
  final otherTask=RxList<TaskModel>([]);

  addTask(TaskModel taskModel) {
    Get.defaultDialog(
        title: "Add Task",
        titleStyle: titleTextStyle,
        middleText: "Are you sure you want to add this task (${taskModel.taskTitle}) ",
        middleTextStyle: const TextStyle(fontSize: 20),
        confirm: ElevatedButton(
            onPressed: (){
              TaskService.addTask(taskModel);
              getTasksList();
              Get.offAll(TodoPage());
              Get.snackbar("Add Task", "Successfully added task");
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
    List<TaskModel> tasks=await TaskService.getTasks();
    todayTask.length=0;
    otherTask.length=0;
    for(var item in tasks){
      if(item.taskDate==DateFormat("yyyy-MM-dd").format(DateTime.now()).toString()){
        todayTask.add(item);
      }else{
        otherTask.add(item);
      }
    }
    return [todayTask,otherTask];
  }

  deleteTask(TaskModel taskModel){
    Get.defaultDialog(
        title: "Delete Task",
        titleStyle: titleTextStyle,
        middleText: "Are you sure you want to Delete this task (${taskModel.taskTitle}) ",
        middleTextStyle: const TextStyle(fontSize: 20),
        confirm: ElevatedButton(
            onPressed: (){
              TaskService.deleteTask(taskModel.taskID);
              getTasksList();
              Get.back();
              Get.snackbar("Delete Task", "Successfully delete task");
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

  setFinish(TaskModel taskModel){
    if(taskModel.taskStatue==0){
      Get.snackbar("Task Finished", "Successfully finish task");
    }else{
      Get.snackbar("Task Unfinished", "Remember to finish the task");
    }
    TaskService.setFinish(taskModel);
    getTasksList();

  }

}