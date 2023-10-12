import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/eventbus.dart';
import 'ggesture_state.dart';

//在Getx中使用 AnimationController，添加上 with GetSingleTickerProviderStateMixin

class GgestureLogic extends GetxController with GetSingleTickerProviderStateMixin {
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
    state.animationColor = ColorTween(begin: Colors.black, end: Colors.red).animate(state.animationController);
    if (state.setNum == 2) {
      state.textTip = "请设置手势密码";
    }
    update();
  }

  opF() {
    print("点击动画");
    state.animationController.forward();
  }

  // 设置密码
  setPwd(List<int> setPwds) {

    // 设置密码要输入两次
    print("输入的密码为:$setPwds");

    // 第一次设置
    if (state.setNum == 2) {
      state.setNum = state.setNum - 1;
      state.textTip = "请再次设置手势密码";
      // 保存第一个设置密码
      state.setPwd = setPwds;
    }

    // 现在的设置次数 = 2 ，提示：请设置密码  =1 请再次输入密码 = 0 请输入手势密码
    else if (state.setNum == 1) {
      state.setNum = state.setNum - 1;
      state.textTip = "请输入手势密码";

      // 当设置密码成功后，发起一个事件通知 panlogic 密码设置成功，之后再收入密码就不用调用 setPwd 方法，直接检测密码
      if (checkSetCorrct(setPwds)) {
        print("设置密码成功:${state.setPwd}");
        eventBusG.fire(EventSuccessSetPwd(true));
      }
      // 密码设置错误时，初始化信息，重新输入
      else {
        eventBusG.fire(EventSuccessSetPwd(false));
        state.animationController.forward();
        state.setNum = 2;
        state.textTip = "两次密码不一致，请重新输入";
        state.textColor = Colors.red;
      }
    }
    // 如果设置密码不为空则，可以开始判断密码是否正确
    // 如果设置密码为空则，将传入回来的密码设置为设置密码
    update();
  }

  // 判断两次设置密码是否相等
  bool checkSetCorrct(List<int> pwd) {
    print("设置的第一个密码是：${state.setPwd}");
    print("设置的最后一个密码是:$pwd");
    List<int> fir = state.setPwd;
    List<int> sed = pwd;
    return check(fir,sed);
  }

  bool checkResult(List<int> items){
    print("输出的最终密码是:$items");
    print(check(items, state.setPwd)?"与设置密码一致，登录正确":"与设置密码不一致,请重新输入");

    // 输入错误
    if(!check(items, state.setPwd)){
      // 输入次数 -1
      state.inNum = state.inNum -1;

      /* 输入次数 <= 0 次*/
      if(state.inNum <= 0){
        state.textColor = Colors.amber;
        state.textTip = "输入已达上限，请明日再来";
      }
      else{
        state.textColor = Colors.red;
        state.textTip = "密码错误,请重新输入";
      }
      state.animationController.forward();
      print("还有${state.inNum}次机会");
      return false;
    }
    state.textColor = Colors.black;
    state.textTip = "请输入手势密码";
    update();
    return true;
    // 跳转到 下一个页面
  }

  // 判断两个密码是否相等
  bool check(List<int> fir,sed){
    // 现在判断这两个密码是否相等
    /* 两个密码的长度*/
    if (fir.length == sed.length) {
      for (int i = 0; i < fir.length; i++){
        // 两个密码中间有元素不相等
        if(fir[i] != sed[i]){
          return false;
        }
      }
      print("这两个密码相等:${state.setPwd}");
      return true;
    }
    else {
      return false;
    }
  }

  // 限制输入密码次数
}
