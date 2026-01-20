//管理路由
import 'package:flutter/material.dart';
import 'package:flutter_hmshop/pages/Login/index.dart';
import 'package:flutter_hmshop/pages/Main/index.dart';

//返回App根级组件
Widget getRootWidget (){
  return MaterialApp(
    //命名路由
    initialRoute: "/",//默认路由
    routes: getRootRoutes(),
  );
}

//返回该App的路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes(){
  return {
    "/": (context) => MainPage(),//主页路由
    "/login": (context) => LoginPage(),//登录路由
  };
}