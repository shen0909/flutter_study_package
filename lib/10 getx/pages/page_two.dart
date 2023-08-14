import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class pageTwo extends StatelessWidget {
  var controler = Get.find<pageTwoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page_two"),),
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${controler.text}"),
              GetBuilder<pageTwoController>(builder: (logic) {
                return Text("${controler.data}");
              }),
              Obx(() {
                return Text("${controler.i}");
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controler.caculate(true);
                      },
                      child: Icon(Icons.add)),
                  SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: () {
                        controler.caculate(false);
                      },
                      child: Icon(Icons.remove)),
                  SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: () {
                        controler.change();
                      },
                    child: Icon(Icons.undo),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class pageTwoController extends GetxController {

  RxInt i = 0.obs;
  List<String> content = ["111", "222", "333"];

  String text = "pageTwo的controller";
  var data = "";

  @override
  void onInit() {
    data = Get.arguments;
    update();
  }

  void caculate(isadd) {
    if (isadd) {
      i++;
    }
    else {
      i--;
    }
  }

  void change() {
    data = content[Random().nextInt(content.length)];
    update();
  }
}