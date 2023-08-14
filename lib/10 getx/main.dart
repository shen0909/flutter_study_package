import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/10%20getx/routers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'getx_依赖注入/getx_dependency.dart';

// main()=>runApp(MyApp());

class GetXpage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Flutter Demo",
      initialBinding: bind1(),
      debugShowCheckedModeBanner: false,
      getPages: getRouters.getpages,
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
        title: Text("GetX"),
      ),
      body: Center(
        child:Container(
          child:ElevatedButton(
            onPressed: (){
              Get.toNamed('/page_one');
            },
            child: Text("page_one"),
          )
        ),
      ),
    );
  }
}