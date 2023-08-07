import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../7 路由管理/pages/main_page.dart';
import '../7 路由管理/pages/page_one.dart';
import '../路由导航/erro_page.dart';

//路由封装
class Routers{
  static final Map<String,WidgetBuilder> routers={
    '/':(context)=>MainPage(),
    '/one':(context)=>Page_one(),
  };
  static RouteFactory onGenerateRoute=(setting){
    if(setting.name=='/'){
      return MaterialPageRoute(builder: (context){return MainPage();});
    }
    if(setting.name=='/one'){
      return MaterialPageRoute(builder: (context){return Page_one(get_router: setting.arguments,);});
    }
  };

  //跳转错误显示页面
  static final RouteFactory unknowRoute=(settings){
    return MaterialPageRoute(builder: (context){
      return HYErroPage();
    });
  };
}