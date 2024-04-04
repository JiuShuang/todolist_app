import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_app/config/constant.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/controller/taskController.dart';
import 'package:todolist_app/model/taskModel.dart';
import 'package:todolist_app/service/taskService.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {

    print("创建页面AddPage");

    final TextEditingController titleController=TextEditingController();
    final TextEditingController noteController=TextEditingController();
    final TextEditingController dateController=TextEditingController();
    final TextEditingController startController=TextEditingController();
    final TextEditingController endController=TextEditingController();
    final TextEditingController remindController=TextEditingController();
    var selectColors=0.obs;
    TaskController taskController=Get.put(TaskController());

    selectColor(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Colors",style: titleTextStyle,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children:List<Widget>.generate(3, (int index){
                  return GestureDetector(
                    onTap: (){
                      selectColors.value=index;
                    },
                    child: Container(
                      width: 25,
                      height: 25,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: taskColors[index]
                      ),
                      child: Obx(()=>selectColors.value==index?Icon(Icons.done,color: Colors.white):Container())
                    ),
                  );
                }),
              ),
              TextButton.icon(
                  style:TextButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.8),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  onPressed: (){
                    TaskModel taskModel=TaskModel(
                        taskID: null,
                        taskTitle:titleController.text,
                        taskNote:noteController.text,
                        taskDate:dateController.text,
                        startTime:startController.text,
                        endTime:endController.text,
                        remindTime:remindController.text,
                        taskColors:selectColors.value);
                    taskController.addTask(taskModel);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Task")
              )
            ],
          )
        ],
      );
    }
    remindPicker(TextEditingController controller){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Remind",style: titleTextStyle,),
          Container(
            width: 400,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade600.withOpacity(0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width:210,
                  child: TextField(
                    controller: controller,
                    enabled: false,
                    decoration: const InputDecoration(
                        hintText:"Remind Time",
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                ),
                DropdownButton(
                  focusColor: Colors.redAccent,
                  items: <String>['5 Minute', '10 Minute', '15 Minute'].map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width: 100,
                          child: Text(value,style: const TextStyle(fontSize: 17),),
                        )
                    );
                  }).toList(),
                  onChanged: (e){
                    controller.text=e!;
                  },
                  underline: Container(width: 0),
                )
              ],
            ),
          )
        ],
      );
    }
    timeField(BuildContext context,String title,String hintText,TextEditingController controller){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleTextStyle,),
          Container(
            width: 170,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade600.withOpacity(0.3),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: controller,
                    enabled: false,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: hintText,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async{
                      TimeOfDay? timeOfDay=await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute)
                      );
                      if(timeOfDay!=null){
                        controller.text=timeOfDay.format(context);
                      }
                    },
                    icon: Icon(Icons.update_outlined,color:Colors.white.withOpacity(0.5),)
                )
              ],
            ),
          ),
        ],
      );
    }
    dateField(BuildContext context,TextEditingController controller){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date",style: titleTextStyle,),
          Container(
            width: 400,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade600.withOpacity(0.3),
            ),
            child: Row(
              children: [
                SizedBox(
                  width:300,
                  child: TextField(
                    controller: controller,
                    enabled: false,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        hintText: "Enter Data",
                        border:OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      DateTime? taskData = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year+50),
                      );
                      if(taskData!=null){
                        controller.text=DateFormat("yyyy-MM-dd").format(taskData).toString();
                      }
                    },
                    icon: Icon(Icons.calendar_month,color: Colors.white.withOpacity(0.5),)
                )
              ],
            ),
          ),
          SizedBox(height: 20,)

        ],
      );
    }
    textField(String title,String hintText,TextEditingController controller){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleTextStyle,),
          TextField(
            controller: controller,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                hintText: hintText,
                fillColor:Colors.grey.shade600.withOpacity(0.3),
                filled: true,
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                )
            ),
          ),
          SizedBox(height: 20,)
        ],
      );
    }
    appBar(){
      return AppBar(
        leading: IconButton(
          onPressed: (){
            Get.offNamed("/TodoPage");
          },
          icon: Icon(Icons.arrow_back_sharp,color: Colors.white),
        ),
        title: Text("Add Task",style: barTextStyle,),
        centerTitle: true,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textField("Title","Enter Title",titleController),
                textField("Note","Enter Note",noteController),
                dateField(context,dateController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeField(context, "Start" ,"Start Time",startController),
                    const SizedBox(width: 10,),
                    timeField(context, "End" ,"End Time",endController),
                  ],
                ),
                const SizedBox(height: 20,),
                remindPicker(remindController),
                const SizedBox(height: 20,),
                selectColor()
              ],
            ),
          )
        ],
      ),
    );

  }


}



