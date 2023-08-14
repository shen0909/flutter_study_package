import 'package:flutter/cupertino.dart';
import '1 基础widget/key/key.dart';
import '1 基础widget/日历/CalendarDatePicker2.dart';
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
  };
}