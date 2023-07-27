import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//获取数据示例
//包含网络返回数据的类
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'userId':this.id,
    };
  }
}

//获取网络数据的方法
Future<Album> fetchAlbum() async {
  /*使用 http.get() 方法从 JSONPlaceholder 上获取到一个样本相册数据
   * http.get() 方法会返回一个包含 Response 的 Future。
   * Future 是 Dart 用来处理异步操作的一个核心类，它通常代表一个可能的值或者将来或许会用到的错误。
   * http.Response 类包含成功的 http 请求接收到的数据。 */
  //我们需要将 http.Response 转换成一个 Dart 对象
  //1、创建一个包含网络请求返回数据的 Album 类
  //2、将json数据转换成Album对象

  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("response:${response.body}");
    /*response.body是一个json数据格式，
     *jsonDecode(response.body)返回的是一个Map<String, dynamic>类型
     *Album.fromJson(jsonDecode(response.body))会将Map<String, dynamic>类型转换成Alum对象 */

    //返回一个Album对象
    return Album.fromJson(jsonDecode(response.body));
  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

void main()=>runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //获取读取到的数据
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  //显示数据————>使用FutureBuilder组件（异步UI更新的方法之一）
  /*future就是即将处理的异步任务
   *builder：Widget构建器；该构建器会在Future执行的不同阶段被多次调用，构建器签名如下：
   *Function (BuildContext context, AsyncSnapshot snapshot)
   *snapshot会包含当前异步任务的状态信息及结果信息*/
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch Data Example",
      home: Scaffold(
        appBar: AppBar(title: const Text('Fetch Data Example'),),
        body: Center(
          child: FutureBuilder<Album>(
              future: futureAlbum,
              builder: (context,snapshot){
                if (snapshot.hasData) {
                  return Text(snapshot.data!.title);
                }
                else if (snapshot.hasError) {
                return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }


}
