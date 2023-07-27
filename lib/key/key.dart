import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "key——>transfer color",
      debugShowCheckedModeBanner: false,
      home: keyTransfer(),
    );
  }
}
class keyTransfer extends StatefulWidget {
  const keyTransfer({Key? key}) : super(key: key);

  @override
  State<keyTransfer> createState() => _keyTransferState();
}

class _keyTransferState extends State<keyTransfer> {
  List<Widget> colorPan=[];
  List<Widget> colorPan2=[];

  @override
  void initState() {
    super.initState();
    colorPan=[
      StatelessContainer(),
      StatelessContainer(),
    ];
    colorPan2=[
      Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.all(8.0),
        child: StatefulContainer(),
      ),
      Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.all(8.0),
        child: StatefulContainer(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("无状态——>"),
                  SizedBox(width: 30,),
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    children: colorPan,
                  ),
                  SizedBox(height: 20,),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("有状态——>"),
                  SizedBox(width: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: colorPan2,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchWidget,
        child: Icon(Icons.undo),
      ),
    );
  }

  //将colorPan的第一个颜色插入到第二个位置，并且使用setStateflutter框架重新渲染屏幕
  switchWidget(){
    colorPan.insert(0, colorPan.removeAt(1));
    colorPan2.insert(0, colorPan2.removeAt(1));
    setState(() {});
  }
}

class StatelessContainer extends StatelessWidget {

  // final Color color = Color.fromARGB(128, 255, 0, 0);
  final Color color=Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}

class StatefulContainer extends StatefulWidget {
  const StatefulContainer({Key? key}) : super(key: key);

  @override
  State<StatefulContainer> createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  final Color color=Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: color,
    );
  }
}



