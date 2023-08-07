/*封装信息*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../About_page.dart';
import '../Route.dart';
import '../detail.dart';
import '../erro_page.dart';
class Routerss{

  static final Map<String,WidgetBuilder> routes={
    "/":(ctx)=>HYpage(),
    //"/about":(ctx)=>HYAboutPage(),
    // key : 值 法
    HYAboutPage.routeName:(ctx)=>HYAboutPage(),
  };

  static final RouteFactory GenerateRoute=(settings){
    if(settings.name =="/detail"){
      return MaterialPageRoute(builder: (context){
        return HYDetailPage("${settings.arguments}");
      });
    }
    return null;
  };

  //跳转错误显示页面
  static final RouteFactory unknowRoute=(settings){
    return MaterialPageRoute(builder: (context){
      return HYErroPage();
    });
  };
}