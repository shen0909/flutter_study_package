import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gesture_page.dart';

main()=>runApp(GstMyApp());

class GstMyApp extends StatelessWidget {
  const GstMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      home: gHYHomePage(),
    );
  }
}
class gHYHomePage extends StatelessWidget {
  const gHYHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("手势密码登录"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_sharp,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GesturePage(),
    );
  }
}

