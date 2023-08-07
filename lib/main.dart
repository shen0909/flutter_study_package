import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main_router.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      routes: main_router.routers,
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
        title: Text("Flutter学习Demo合集"),
      ),
      body: ButtonPage(),
    );
  }
}

class ButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
               width: 150,
               child: Row(
                 children: [
                   ElevatedButton(
                       onPressed: (){
                         print("去key值");
                         Navigator.pushNamed(context, "/key");
                       },
                       child: Text("去key值")),
                   Text("key键"),
                 ],
               ),
             ),
              Container(
                width: 250,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          print("日历");
                          Navigator.pushNamed(context, "/datePicker");
                        },
                        child: Text("日历")),
                    Text("日历CalendarDatePicker2"),
                  ],
                ),
              ),
              Container(
                width: 100,
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          print("Json");
                          Navigator.pushNamed(context, "/Json");
                        },
                        child: Text("Json")),
                    Text("Json"),
                  ],
                ),
              ),
              Container(
                width: 200,
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          print("Json");
                          Navigator.pushNamed(context, "/Json");
                        },
                        child: Text("Json")),
                    Text("Json"),
                  ],
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
