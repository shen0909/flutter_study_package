import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var get_data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主页"),
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  //使用路由钩子后，此时的参数无法传递到下一页
                  /*这是因为在使用路由钩子时，您需要将要传递的参数放在RouteSettings对象中，并将该对象作为参数传递给Navigator.push方法。
                   *这是因为路由钩子返回的是一个Route对象，而不是一个页面组件。因此，您需要使用RouteSettings对象来传递数据。*/
                  var futureResult=Navigator.pushNamed(context, "/one", arguments: "这是从主页跳转来到page_one的");
                  futureResult.then((value){
                    setState(()=>get_data= "${value}");
                  });

                },
                child: Text("跳转到page_one")),
            Text("从get_data返回数据:${get_data}",style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }
}
