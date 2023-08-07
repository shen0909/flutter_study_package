import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main()=>runApp(
  ChangeNotifierProvider(create: (_)=>message(),child: MyApp(),)
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "数据持久化",
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据持久化"),
      ),
      body: Center(
        child: Container(
          width: 320,
          child: Column(
            children: [
              InputPage(),
              SizedBox(height: 20,),
              ShowPage(),
            ],
          ),
        ),
      ),
    );
  }
}

//共享数据
class message extends ChangeNotifier{
  String name="杨滨溶";
  String age="23";

  void update(String newname,String newage){
    name=newname;
    age=newage;
    notifyListeners();
  }
}

class InputPage extends StatefulWidget {

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  final namecontroller=TextEditingController();
  final agecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller:namecontroller ,
            decoration: InputDecoration(
                hintText: "请输入名字"
            ),
          ),
          TextField(
            controller:agecontroller ,
            decoration: InputDecoration(
                hintText: "请输入年龄"
            ),
          ),
          SizedBox(height: 40,),
          ElevatedButton(
              onPressed: ()=>tapbutton(context,namecontroller.text,agecontroller.text),
              child: Text(
                "提交",
              ))
        ],
      ),
    );
  }

  void tapbutton(context,name,age){
    Provider.of<message>(context,listen: false).update(name,age);
    print("提交信息");
  }
}

//获取Provider中的数据进行展示
class ShowPage extends StatelessWidget {
  const ShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<message>(
        builder: (context,example,child){
          return Row(
            children: [
              Text("从Provider中获取数据"),
              SizedBox(width: 20,),
              Text("NAME:${example.name}",style: TextStyle(color: Colors.red,fontSize:14),),
              SizedBox(width: 20,),
              Text("AGE:${example.age}",style: TextStyle(color: Colors.red,fontSize:14),),
            ],
          );
        },
      ),
    );
  }
}

//数据模型model
class messageModel{

}