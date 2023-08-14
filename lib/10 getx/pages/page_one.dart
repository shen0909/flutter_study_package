import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class pageOne extends StatelessWidget {
  var controler=Get.find<pageOneController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page_one"),),
      body: Container(
        color: Colors.red,
        child: Column(
          children: [
            Text("${controler.text}"),
            ElevatedButton(
              onPressed: (){
                Get.toNamed('/page_two',arguments: "这是从pageone传过来的数据");
              },
              child: Text("page_one"),
            ),
          ],
        ),
      ),
    );
  }
}

class pageOneController extends GetxController {

  String text="pageone的controller";

}