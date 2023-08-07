import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main()=>runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>favorite()),
    ChangeNotifierProvider(create: (_)=>food(),),
  ],
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "收藏",
      home: HYHomePage(),
    );
  }
}
//消费者 Provider.of(context)
class HYHomePage extends StatelessWidget {

  const HYHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("收藏示例"),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            demo1Provider(),
            SizedBox(height: 20,),
            demo2Consumer(),
            SizedBox(height: 20,),
            demo3Selector(),
            SizedBox(height: 20,),
            demo4Selector(),
          ],
        ) ,
      ),
    );
  }
}
/*Provider.of<T>(context) 是 Provider 为我们提供的静态方法，
当我们使用该方法去获取值的时候会返回查找到的最近的 T 类型的 provider 给我们，且也不会遍历整个组件树。*/
class demo1Provider extends StatelessWidget {
  const demo1Provider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo=Provider.of<favorite>(context);
    final demo2=Provider.of<food>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width:100,child: Text("喜欢Provider")),
        SizedBox(width: 20,),
        InkWell(
          onTap: (){
            demo.modify();
            demo2.addfood("一只猫猫爪");
          },
          child: demo.isfavorite? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border_rounded,),
        ),
        SizedBox(width: 20,),
        Text("当前是否喜欢:  ${context.read<favorite>().isfavorite}"),
        SizedBox(width: 20,),
        Text("${demo2.foods}"),
      ],
    );
  }
}

class demo2Consumer extends StatelessWidget {
  const demo2Consumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<favorite,food>(
      builder: (context,instancs,foodinstanc,child){
        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width:100,child:Text("喜欢Consumer"),),
            SizedBox(width: 20,),
            InkWell(
              onTap: (){
                print("添加到喜欢");
                instancs.modify();
                foodinstanc.addfood("大芒果");
                print("当前是否喜欢:${context.read<favorite>().isfavorite}");
              },
              child:instancs.isfavorite?
              Icon(Icons.favorite,color: Colors.red,):
              Icon(Icons.favorite_border_rounded,),
            ),
            SizedBox(width: 20,),
            Text("当前是否喜欢:  ${context.read<favorite>().isfavorite}"),
            SizedBox(width: 20,),
            Text("${foodinstanc.foods}"),
          ],
        );
      },
    );
  }
}

class demo3Selector extends StatelessWidget {
  const demo3Selector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final demo22=Provider.of<food>(context);
    return Selector<favorite,favorite>(
      selector:(context,favoritedemo)=>favoritedemo,
      shouldRebuild: (pre,next)=>true,
      builder: (context,demo1,child){
        return  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width:100,child:Text("喜欢Selector"),),
              SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  demo1.modify();
                  demo22.addfood("孙悟空最喜欢的桃子");
                },
                child: demo1.isfavorite? Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border_rounded,),
              ),
              SizedBox(width: 20,),
              Text("当前是否喜欢:  ${demo1.isfavorite}"),
              SizedBox(width: 20,),
              Text("${Provider.of<food>(context).foods}"),
            ],
          );
        }, );
  }
}

class demo4Selector extends StatelessWidget {
  const demo4Selector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<favorite,bool>(
      selector:(context,favoritedemo)=>favoritedemo.isfavorite,
      shouldRebuild: (pre,next)=>true,
      builder: (context,demo1,child){
        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width:150,child:Text("喜欢Selectorbool"),),
            demo1?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border_rounded,),
            SizedBox(width: 20,),
            Text("当前是否喜欢:  ${demo1}"),
            SizedBox(width: 20,),
            Text("${Provider.of<food>(context).foods}"),
          ],
        );
      }, );
  }
}

//真正的数据存放处
class favorite extends ChangeNotifier{

  bool isfavorite=false;

  void modify(){
    isfavorite=!isfavorite;
    notifyListeners();
  }
}

class food extends ChangeNotifier{
  List<String> foods=["苹果","李子","桃子","橙子"];

  void addfood(String food){
    foods.add(food);
    notifyListeners();
  }
}