import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'http_manager.dart';

main() async {
  runApp(DioUsePage());
}

class DioUsePage extends StatelessWidget {
  const DioUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      home: DioUse(),
    );
  }
}

class DioUse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // dio_use();
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            saveImage();
          },
          child: Text("保存图片到本地"),
        ),
      ),
    );
  }
}

Future<void> saveImage() async {
  print("保存图片到本地");
  //下载图片
  var result = await HttpManager.getInstance().get(
      "https://img03.sogoucdn.com/v2/thumb/retype_exclude_gif/ext/auto/crop/xy/ai/w/1284/h/722?appid=200698&url=https://pic.baike.soso.com/ugc/baikepic2/24446/cut-20211222173333-829293243_jpg_1308_872_50708.jpg/0",
      //将返回类型设置为二进制,此时的result是二进制数据,保存的是图片的字节数组
      option: Options(responseType: ResponseType.bytes));
  //选择文档目录
  //selectedDirectory是选择的文件夹的地址  C:\Users\lanlian\Desktop\沈成林\休闲娱乐来一套\下载图片
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
  if (selectedDirectory == null) {
    print("请选择正确的文件地址");
    return;
  }
  else{
    print("selectedDirectory:${selectedDirectory}");
    //创建一个名为download1.jpg的新文件
    File image_file=File('${selectedDirectory}/download1.jpg');
    if(image_file.existsSync()){
      print("图片已存在");
      return;
    }
    //从网络上下载的图片的字节数组写入该文件中。
    image_file.writeAsBytes(result);
  }
}

void dio_use() async {
  //get 无参
  await HttpManager.getInstance().get(
    // "https://api.github.com/orgs/flutterchina/repos?id=189944669",
    "https://reqres.in/api/users",
    option: Options(responseType: ResponseType.plain),
  );

  // 获取id 法一
  await HttpManager.getInstance().get("https://reqres.in/api/users/1");

  // 获取id 法二
  await HttpManager.getInstance().get("https://reqres.in/api/users?id=2");

  // 获取id 法三 用参数类型
  Map<String, dynamic> map = Map();
  map["id"] = 3;
  await HttpManager.getInstance().get("https://reqres.in/api/users",
      option: Options(responseType: ResponseType.json), params: map);

  await HttpManager.getInstance().post("FinanceAppAPI/user/queryLoginTradeAccount");

  await HttpManager.getInstance().post("https://www.wanandroid.com/user/register",
      params: {
        "username": "akshfalwhfaina",
        "password": "123456",
        "repassword": "123456"
      });
  HttpManager.getInstance().post("https://demo-api.apipost.cn/api/demo/login",
      params: {"mobile": "123456", "ver_code": "12"});
  HttpManager.getInstance().post(
    "https://lionstock-uat-new.chinaeast2.cloudapp.chinacloudapi.cn:8200/FinanceAppAPI/stock/index",
  );
}
