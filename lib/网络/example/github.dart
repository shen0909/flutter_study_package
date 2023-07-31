import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//dio.get 访问GitHub接口
main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      home: HYHomePage(),
    );
  }
}
class HYHomePage extends StatelessWidget {
  const HYHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: FutureBuilderRoute(),
    );
  }
}
class FutureBuilderRoute extends StatefulWidget {
  const FutureBuilderRoute({Key? key}) : super(key: key);

  @override
  State<FutureBuilderRoute> createState() => _FutureBuilderRouteState();
}

class _FutureBuilderRouteState extends State<FutureBuilderRoute> {
  Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data.map<Widget>((e) =>
                    ListTile(title: Text(e["full_name"]))
                ).toList(),
              );
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          }
      ),
    );
  }
}
