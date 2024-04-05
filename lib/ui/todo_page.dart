import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_app/config/constant.dart';
import 'package:todolist_app/controller/taskController.dart';
import 'package:todolist_app/model/taskModel.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController=Get.put(TaskController());

    taskStatue(e,TaskModel taskModel){
      if(e=="Delete"){
        taskController.deleteTask(taskModel);
      }else{
        taskController.setFinish(taskModel);
      }
    }

    noData(){
      return Container(
        width: 350,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3)
        ),
        child: const Center(
          child: Text(
              "There are currently no tasks assigned by anyone.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        ),
      );
    }

    statueTag(TaskModel taskModel){
      print(taskModel.taskID);
      return Container(
        width: 80,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: LinearGradient(
                colors:
                  taskModel.taskStatue==1?
                  [Colors.blueGrey.withOpacity(0.6),Colors.black26.withOpacity(0.4)]:
                  [Colors.greenAccent.shade200.withOpacity(0.6),Colors.cyanAccent.withOpacity(0.4)],
                begin:Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
        child: Center(
          child: Text(
            taskModel.taskStatue==0?"Unfinished":"Finished",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    taskList(List<TaskModel> tasksList){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today",style: titleTextStyle,),
          Obx(() => Wrap(
              children: tasksList.isNotEmpty?
              List<Widget>.generate(tasksList.length, (index) {
                TaskModel taskModel=tasksList[index];
                return Container(
                  width: 500,
                  height: 120,
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: taskColors[taskModel.taskColors]
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width:300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  taskModel.taskTitle,
                                  style: titleTextStyle,
                                  maxLines: 1,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 10,),
                                statueTag(taskModel),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                const Icon(Icons.timer_outlined,color: Colors.white,),
                                Text("${taskModel.startTime} ~ ${taskModel.endTime}",)
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Text(
                              taskModel.taskNote,
                              style: TextStyle(color: Colors.grey.shade200.withOpacity(0.6)),
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: 0,
                        child: DropdownButton(
                          icon: const Icon(Icons.more_horiz_outlined,size: 32,),
                          focusColor: Colors.redAccent,
                          items: <String>['Finish', 'Delete'].map((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value)
                            );
                          }).toList(),
                          onChanged: (e){
                            taskStatue(e, taskModel);
                          },
                          underline: Container(width: 0),
                        ),
                      ),
                    ],
                  ),
                );
              }):
              [Container()]
          ),)
        ],
      );
    }

    cardList(RxList<TaskModel> tasksList){
      return SizedBox(
        height: 160,
        child: Obx(()=>ListView(
            scrollDirection: Axis.horizontal,
            children: tasksList.isNotEmpty?
            List<Widget>.generate(tasksList.length, (index) {
              TaskModel taskModel=tasksList[index];
              return Container(
                width: 200,
                height: 160,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [Colors.deepPurple.shade400.withOpacity(0.6),Colors.pinkAccent.shade100.withOpacity(0.4)],
                        begin:Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DropdownButton(
                            icon: const Icon(Icons.more_horiz_outlined,size: 32,),
                            focusColor: Colors.redAccent,
                            items: <String>['Finish', 'Delete'].map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value)
                              );
                            }).toList(),
                            onChanged: (e){
                              taskStatue(e, taskModel);
                            },
                            underline: Container(width: 0),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 5,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  colors: [Colors.amber.withOpacity(0.8),Colors.deepOrange.withOpacity(0.6)],
                                  begin:Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskModel.taskTitle,
                              style:todoCardTitleStyle,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            statueTag(taskModel)
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: Colors.grey.shade100.withOpacity(0.75),
                      height: 1,
                      width: 180,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_month,color: Colors.white.withOpacity(0.5),),
                              Text(taskModel.taskDate,style: todoCardTipStyle)
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(Icons.timer_outlined,color: Colors.white.withOpacity(0.5),),
                              Text("${taskModel.startTime} ~ ${taskModel.endTime}",style: todoCardTipStyle)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }):
            [noData()]
        ),)
      );
    }

    appBar(){
      return AppBar(
        title: Text("ToDo",style: barTextStyle),
        actions: [
          IconButton(
              onPressed: (){
                Get.offNamed("/AddPage");
              },
              icon: const Icon(Icons.add,size: 40,)
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(),
      body:FutureBuilder<dynamic>(
        future:taskController.getTasksList(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    cardList(snapshot.data[1]),
                    const SizedBox(height: 20,),
                    taskList(snapshot.data[0]),
                  ],
                )
            );
          }
          return const CircularProgressIndicator();
        },
      )
    );

  }
}
