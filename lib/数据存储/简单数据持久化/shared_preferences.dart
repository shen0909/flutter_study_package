import 'package:shared_preferences/shared_preferences.dart';

main() async {
  sharePreferences.set('exampel', '这是一个测试');
  /*为什么没有加 await 返回的是 Instance of 'Future<dynamic>'？
   *因为 sharePreferences.get() 方法返回的是一个 Future 对象，
   *而不是直接返回数据。Future 对象代表一个异步操作的结果，需要使用 await 关键字来等待异步操作完成并获取其结果。 */
  var data = await sharePreferences.get('exampel');
  print("data:${data}");
  var data2 = await sharePreferences.get('text');
  print("data2:${data2}");
  //清除 exampel 中的数据
   await sharePreferences.remove("exampel");
  var data_remove = await sharePreferences.get('exampel');
  print("data_remove:${data_remove}");

  bool exit1 = await sharePreferences.containsKey('exampel');
  // bool exit1=await sharePreferences.containsKey("exampel");
  print("exit1:$exit1");
  sharePreferences.set('exampel', '这是一个测试');
  bool exit2 = await sharePreferences.containsKey('exampel');
  print("exit2:$exit2");
  print("所有key:${await sharePreferences.getKeys()}");
}


class sharePreferences{

  /*保存数据时，调用set方法，传入key值和需要保存的数据*/
  static set(String key,dynamic value) async {
    //获得SharedPreferences的实例
    var prefer= await SharedPreferences.getInstance();
    // String 类型
    if(value is String){
      prefer.setString(key, value);
    }
    //int 类型
    else if(value is int){
      prefer.setInt(key, value);
    }
    //bool 类型
    else if(value is bool){
      prefer.setBool(key, value);
    }
    //double 类型
    else if(value is double){
      prefer.setDouble(key, value);
    }
    //List 类型
    else if(value is List){
      /*如果 value 是List类型，则将它强制转换成一个字符串列表*/
      prefer.setStringList(key, value.cast<String>());
    }
  }

  // 读取数据
  /*传入key值，从 key 值中读取数据并赋值给data，如果数据为空则返回0*/
  static get(String key) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    var data = prefer.get(key);
    return data ?? "null";
  }

  //清除 key 键的值
  static remove(String key) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.remove(key);
  }
  //清除所有
  static removeall() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    prefer.clear();
  }

  //key 键是否存在
  static containsKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
  //获取所有的key
  static getKeys() async {
    var prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys();
    return keys;
  }
}