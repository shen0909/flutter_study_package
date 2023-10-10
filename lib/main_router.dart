import 'package:flutter/cupertino.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95-getx/main_page.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/main.dart';
import '1 基础widget/key/key.dart';
import '1 基础widget/日历/CalendarDatePicker2.dart';
import '10 getx/main.dart';
import '11 动画/page.dart';
import '2 json和序列化/json.dart';
import '3 状态管理/text/favorite_example/favorite.dart';
import '8 网络/网络封装/main.dart';
import '9 焦点 focus/focus_main.dart';

class main_router{
  static final Map<String,WidgetBuilder> routers={
    '/key':(context)=>keyTransfer(),
    '/datePicker':(context)=>MyHomePage(title: '',),
    '/Json':(context)=>Json(),
    '/DioUsePage':(context)=>DioUse(),
    '/provider':(context)=>ProviderMyApp(),
    '/Focus':(context)=>FocusMain(),
    '/getx':(context)=>GetXpage(),
    '/动画':(context)=>AnimationPages(),
    '/手势登录-非getx':(context)=>gHYHomePage(),
    '/手势登录-getx':(context)=>GMainPage(),
  };
}