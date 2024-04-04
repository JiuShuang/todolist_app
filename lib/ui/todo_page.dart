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
    return Scaffold(
      appBar: _appBar(),
      body:FutureBuilder<dynamic>(
        future:taskController.getTasksList(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _cardList(snapshot.data[1]),
                    const SizedBox(height: 20,),
                    _taskList(snapshot.data[0]),
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

_taskList(List<TaskModel> tasksList){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Today",style: titleTextStyle,),
      Wrap(
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
                      Text(
                        taskModel.taskTitle,
                        style: titleTextStyle,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
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
                    icon: const Icon(Icons.more_horiz_outlined),
                    focusColor: Colors.redAccent,
                    items: <String>['Finish', 'Update', 'Delete'].map((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                      );
                    }).toList(),
                    onChanged: (e){},
                    underline: Container(width: 0),
                  ),
                ),
              ],
            ),
          );
        }):
        [Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text("No tasks at the moment",style: TextStyle(fontSize: 20)),
          ),
        )]
      ),
    ],
  );
}

_cardList(List<TaskModel> tasksList){
  return SizedBox(
    height: 160,
    child: ListView(
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
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.more_horiz_outlined,color: Colors.white10.withOpacity(0.5),size: 35,)
                    )
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
                  Text(
                    taskModel.taskTitle,
                    style:todoCardTitleStyle,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
      [const Center(
        child: Text("No tasks at the moment"),
      )]
    ),
  );
}

_appBar(){
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