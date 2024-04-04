import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/config/db_util.dart';
import 'package:todolist_app/router/app_router.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBUtil.initDB("task");
  runApp(GetMaterialApp(
    initialRoute: "/TodoPage",
    getPages:AppRouter.appRouters(),
    theme: ThemeData.dark(),
  ));
}