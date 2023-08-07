import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/7%20%E8%B7%AF%E7%94%B1%E7%AE%A1%E7%90%86/routers.dart';
//7 路由管理
main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "7 路由管理",
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute:Routers.onGenerateRoute,
      /*当我们打开的路由名称，根本不存在时使用onUnknownRoute可以跳转到一个统一的错误页面*/
      onUnknownRoute: Routers.unknowRoute,
    );
  }
}