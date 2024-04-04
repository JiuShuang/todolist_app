import 'package:get/get.dart';
import 'package:todolist_app/router/router_binding.dart';
import 'package:todolist_app/ui/add_page.dart';
import 'package:todolist_app/ui/todo_page.dart';

class AppRouter{

  static List<GetPage> appRouters(){
    List<GetPage> allRouters=[
      GetPage(name: '/TodoPage', page: ()=> TodoPage()),
      GetPage(name: '/AddPage', page: ()=> AddPage())

    ];
    return allRouters;
  }

  static String initRouter(){
    return '/TodoPage';
  }


}