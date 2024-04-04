import 'package:get/get.dart';
import 'package:todolist_app/controller/taskController.dart';
class RouterBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(TaskController());
  }

}