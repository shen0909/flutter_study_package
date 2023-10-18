import 'package:shared_preferences/shared_preferences.dart';

// 简单持久化类
class SharePrefer{

  static const String pwdKey = "pwdKey";

  static set(String key,dynamic value) async {
    var seter = await SharedPreferences.getInstance();
    // String 类型
    if(value is String){
      seter.setString(key, value);
    }
    //int 类型
    else if(value is int){
      seter.setInt(key, value);
    }
    //bool 类型
    else if(value is bool){
      seter.setBool(key, value);
    }
    //double 类型
    else if(value is double){
      seter.setDouble(key, value);
    }
    //List 类型
    else if(value is List){
      /*如果 value 是List类型，则将它强制转换成一个字符串列表*/
      seter.setStringList(key, value.cast<String>());
    }

  }

  static get(String key,[dynamic replace]) async {
    var getter = await SharedPreferences.getInstance();
    var result = getter.get(key);
    return result ?? replace;
  }

  //key 键是否存在
  static containsKey(String key) async {
    var conter = await SharedPreferences.getInstance();
    return conter.containsKey(key);
  }

}