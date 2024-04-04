class TaskModel {
  final int? taskID;
  final String taskTitle;
  final String taskNote;
  final String taskDate;
  final String startTime;
  final String endTime;
  final String remindTime;
  final int taskColors;

  TaskModel({
    required this.taskID,
    required this.taskTitle,
    required this.taskNote,
    required this.taskDate,
    required this.startTime,
    required this.endTime,
    required this.remindTime,
    required this.taskColors,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : taskID=json['taskID'],
        taskTitle = json['taskTitle'],
        taskNote = json['taskNote'],
        taskDate = json['taskDate'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        remindTime = json['remindTime'],
        taskColors = json['taskColors'];



  Map<String, Object?> toMap()=> {
      'taskID':taskID,
      'taskTitle':taskTitle,
      'taskNote': taskNote,
      'taskDate':taskDate,
      'startTime':startTime,
      'endTime':endTime,
      "remindTime":remindTime,
      "taskColors":taskColors
  };

}