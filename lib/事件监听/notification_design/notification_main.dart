import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'notification.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("初始定义"),
        ),
        body: BodyPage(),
      ),
    );
  }
}

class BodyPage extends StatelessWidget {
  List<String> datas = ["朱一龙", "肖战", "王一博", "白宇"];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        child: NotificationListener<CustomNotification>(
          onNotification: (notification) {
            print("监听的子widget是Center:${notification.data}");
            return false;
          },
          child: Center(
            child: NotificationListener<CustomNotification>(
              onNotification: (notification) {
                print("监听的子widget是Column:${notification.data}");
                return true;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("这是一些名字"),
                  Container(
                    height: 500,
                    width: 300,
                    color: Colors.amber,
                    child: ListView.builder(
                        itemCount: datas.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 30,
                            child: Row(
                              children: [
                                Text("${datas[index]}"),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      CustomNotification(datas[index])
                                          .dispatch(context);
                                    },
                                    child: Text("分发"))
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
