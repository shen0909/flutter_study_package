import 'package:dio/dio.dart';
import 'package:flutterapp/%E7%BD%91%E7%BB%9C/%E7%BD%91%E7%BB%9C%E5%B0%81%E8%A3%85/http_manager.dart';
main() async{
   //get 无参
   HttpManager.getInstance().get(
      // "https://api.github.com/orgs/flutterchina/repos?id=189944669",
     "https://reqres.in/api/users",
     option: Options(responseType: ResponseType.plain),
  );

   // 获取id 法一
   HttpManager.getInstance().get("https://reqres.in/api/users/1");

   // 获取id 法二
   HttpManager.getInstance().get("https://reqres.in/api/users?id=2");

   // 获取id 法三 用参数类型
   Map<String,dynamic> map = Map();
   map["id"]= 3;
   HttpManager.getInstance().get(
     "https://reqres.in/api/users",
     option: Options(responseType: ResponseType.json),
     params:map
   );
  // HttpManager.getInstance().post();
}

