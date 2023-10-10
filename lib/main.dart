import 'package:flutter/material.dart';
import 'package:flutterapp/main_router.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      debugShowCheckedModeBanner: false,
      routes: main_router.routers,
      home: const HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {
  const HYHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter学习Demo合集"),
      ),
      body: const ButtonPage(),
    );
  }
}

class ButtonPage extends StatelessWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                 width: 100,
                 child: Row(
                   children: [
                     ElevatedButton(
                         onPressed: (){
                           print("去key值");
                           Navigator.pushNamed(context, "/key");
                         },
                         child: const Text("去key值")),
                   ],
                 ),
               ),
                SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            print("日历");
                            Navigator.pushNamed(context, "/datePicker");
                          },
                          child: const Text("日历")),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            print("Json");
                            Navigator.pushNamed(context, "/Json");
                          },
                          child: const Text("Json")),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            print("DioUsePage");
                            Navigator.pushNamed(context, "/DioUsePage");
                          },
                          child: const Text("DioUsePage")),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            print("provider");
                            Navigator.pushNamed(context, "/provider");
                          },
                          child: const Text("provider")),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            print("FocusPage");
                            Navigator.pushNamed(context, "/Focus");
                          },
                          child: const Text("Focus")),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          print("getx");
                          Navigator.pushNamed(context, "/getx");
                        },
                        child: const Text("getx")),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          print("动画");
                          Navigator.pushNamed(context, "/动画");
                        },
                        child: const Text("动画")),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: (){
                    print("getx");
                    Navigator.pushNamed(context, "/手势登录-非getx");
                  },
                  child: const Text("手势密码登录-非getx")),
              const SizedBox(width: 20,),
              ElevatedButton(
                  onPressed: (){
                    print("getx");
                    Navigator.pushNamed(context, "/手势登录-getx");
                  },
                  child: const Text("手势密码登录-getx")),
            ],
          ),
        ],
      ),
    );
  }
}
