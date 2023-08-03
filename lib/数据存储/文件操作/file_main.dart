import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file_help.dart';

main()  {

  FileHelp().deletefile();

  FileHelp().writeFile("这是一次测试");

  FileHelp().writeFile("这是另一次测试");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "文件操作",
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatefulWidget {

  @override
  State<HYHomePage> createState() => _HYHomePageState();
}

class _HYHomePageState extends State<HYHomePage> {

  bool exit = false;
  String date = "";

  @override
  void initState() {

    FileHelp().fileExit().then((value) {
      setState(() => exit = value);
    });
    FileHelp().readCounter().then((value) {
      setState(() {
        date = value;
      });
    });
        super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("文件操作"),
      ),
      body: Center(
        child: Text("文件是否存在：${exit}\n\n文件内容：${date}"),
      ),
    );
  }
}
