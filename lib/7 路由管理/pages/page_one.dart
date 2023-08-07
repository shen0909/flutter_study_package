import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page_one extends StatelessWidget {
  var get_router;

  Page_one({this.get_router});

  @override
  Widget build(BuildContext context) {
    //命名路由参数传递
    var get_data = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("page_one"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("红色页面"),
            ElevatedButton(
                onPressed: () {
                  print("page_one 返回主页");
                  Navigator.pop(context, "这里是从page_one返回主页的数据");
                },
                child: Text("返回主页")),
            Text("从主页接收的数据:${get_data}"),
            Text("使用路由钩子从主页接收的数据:${get_router}"),
          ],
        ),
      ),
    );
  }
}
