import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/%E5%8D%95%E4%BE%8B%E6%A8%A1%E5%BC%8F/factory_singleton.dart';
import 'package:flutterapp/%E5%8D%95%E4%BE%8B%E6%A8%A1%E5%BC%8F/getter_singleton.dart';
import '../单例模式/Common_Singleton.dart';
import 'null_judge_singleton.dart';
main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "单例模式",
      home: HYHomePage(),
    );
  }
}
class HYHomePage extends StatelessWidget {

  String text1=commonSingleton.getInstance().text;
  String text2=getterSingleton.instance.text;
  String text3=factroySingleton().text;
  String text4=factroySingletonNullJudget().text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单例模式"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text1,style: TextStyle(fontSize: 20,color: Colors.redAccent),),
            SizedBox(height: 20,),
            Text(text2,style: TextStyle(fontSize: 20,color: Colors.redAccent),),
            SizedBox(height: 20,),
            Text(text3,style: TextStyle(fontSize: 20,color: Colors.redAccent),),
            SizedBox(height: 20,),
            Text(text4,style: TextStyle(fontSize: 20,color: Colors.redAccent),),
          ],
        ),
      ),
    );
  }
}