import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ggesture_state.dart';

//在Getx中使用 AnimationController，添加上 with GetSingleTickerProviderStateMixin

class GgestureLogic extends GetxController with GetSingleTickerProviderStateMixin{
  final GgestureState state = GgestureState();

  @override
  void onInit() {
    state.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      lowerBound: 0.0, //被忽略值
      upperBound: 1.0,
    )
      ..addListener(() {
        update();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          print("颜色动画正在执行");
          state.animationController.reset();
        }
      });
    late CurvedAnimation curvedAnimation = CurvedAnimation(curve: Curves.easeIn, parent: state.animationController);
    state.animationMag = Tween(begin: 0.0, end: 100.0).animate(curvedAnimation);

    state.animationColor = ColorTween(begin: Colors.black,end: Colors.red).animate(state.animationController);

  }

  opF(){
    print("点击动画");
    state.animationController.forward();
  }

  // 判断密码是否正确
  // 限制输入密码次数
  // 设置密码
}
