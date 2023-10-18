import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/eventbus.dart';
import '../common/sharePre.dart';
import 'ggesture_state.dart';

//在Getx中使用 AnimationController，添加上 with GetSingleTickerProviderStateMixin

class GgestureLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final GgestureState state = GgestureState();

  @override
  void onInit() {
    super.onInit();

    // 获取设置密码配置
    isSet();

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
          state.animationController.reset();
        }
      });
    late CurvedAnimation curvedAnimation = CurvedAnimation(curve: Curves.easeIn, parent: state.animationController);
    state.animationMag = Tween(begin: 0.0, end: 100.0).animate(curvedAnimation);
    state.animationColor = ColorTween(begin: Colors.black, end: Colors.red).animate(state.animationController);
    update();
  }

  // 从本地获取设置密码，如果没有则 更新设置信息( 提示语=" 请设置手势密码 " 、设置次数 = 2)
  isSet() async {
    // 未设置
    if( SharePrefer.get(SharePrefer.pwdKey) == null || !( await SharePrefer.containsKey(SharePrefer.pwdKey))){
    state.setNum = 2;
    state.textTip = "请设置手势密码";
    }
    // 否则 获取设置密码并发起设置成功通知
    /* List<Object?> 转换成 List<int> 始终报错
     * 聪明的我将每一个元素取出来转换成 int再放数组*/
    else{
      var getSet = await SharePrefer.get(SharePrefer.pwdKey);

      // print("获取设置密码:${ getSet} + ${getSet.runtimeType}");

      getSet.forEach((e){
        state.setPwd.add(int.parse(e));
      });

      // List<String> ii = getSet.map((e)=> e.toString()).toList();
      // var res = getSet.whereType<int>().toList();
      // print("re:$res + ii:$ii");
      // state.setPwd = getSet.whereType<int>().toList();
      eventBusG.fire(EventSuccessSetPwd(true));
    }
    update();
  }

  // 设置密码 设置密码要输入两次
  setPwd(List<int> setPwd) {

     /* 设置次数 = 2 ，初始未设置的状态，提示：请设置密码
      * =1 提示：请再次输入密码
      * =0 提示：请绘制手势密码 (设置成功)*/
    // 此时if判断的是上一次输入的次数，或者可以理解 这次是第1次设置 =2
    if (state.setNum == 2) {
      /* 将信息全部修改成第二次输入的情况 次数=1 提示："请再次设置手势密码" */
      state.setNum = state.setNum - 1;
      state.textTip = "请再次设置手势密码";
      // 保存第一个设置密码
      state.setPwd = setPwd;
    }

    // 第2次 输入
    else if (state.setNum == 1) {
      /* 将信息全部修改成输入次数结束的情况 次数=0 提示："请再次设置手势密码" */
      state.setNum = state.setNum - 1;
      state.textTip = "请绘制手势密码";

      // 当设置密码成功后，发起一个事件通知 panlogic 密码设置成功，之后再收入密码就不用调用 setPwd 方法，直接检测密码
      if (checkSetCorrct(setPwd)) {
        // 保存密码
        saveSetPwd(state.setPwd);
        eventBusG.fire(EventSuccessSetPwd(true));
      }
      // 密码设置错误时，初始化信息，重新输入
      else {
        eventBusG.fire(EventSuccessSetPwd(false));
        state.animationController.forward();
        state.setNum = 2;
        state.textTip = "两次密码不一致，请重新设置";
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
    return check(fir, sed);
  }

  // 判断输入密码是否正确
  bool checkResult(List<int> items) {

    // 输入错误 每次 输入次数 -1
    if (!check(items, state.setPwd)) {

      // 剩余可用的次数
      state.inNum = state.inNum - 1;

      /* 输入次数 <= 0 次*/
      if (state.inNum <= 0) {
        state.textColor = Colors.amber;
        state.textTip = "输入已达上限，请明日再来";
      } else {
        state.textColor = Colors.red;
        state.textTip = "密码错误,请重新输入";
      }
      state.animationController.forward();
      // print("还有${state.inNum}次机会");
      return false;
    }
    // 判断密码输入正确
    state.textColor = Colors.black;
    state.textTip = "请绘制手势密码";
    update();
    return true;
  }

  // 判断设置密码和输入密码是否相等
  bool check(List<int> inPut,List<int> sed) {

    // 现在判断这两个密码是否相等
    if (inPut.length == sed.length) {

      /* 如果两个密码的长度相等，依次遍历两个密码的元素*/
      for (int i = 0; i < inPut.length; i++) {
        /*两个密码中间有元素不相等  返回false = 不相等*/
        if (inPut[i] != sed[i]) {
          return false;
        }
      }
      /* 两个密码中间元素全部相等  ture = 相等 */
      return true;
    }
    // 如果两个密码的长度不相等，直接返回false
    return false;

  }

  // 保存设置密码
  saveSetPwd(List<int> setPwd) async {

    List<String> resetPwd = setPwd.map((e) => e.toString()).toList();
    await SharePrefer.set(SharePrefer.pwdKey, resetPwd);
  }

  // 错误文字的大小
  double errorPwd() {
    double x = state.animationMag.value; // 变化速度 0-10,
    double d = x - x.truncate(); // 获取这个数字的小数部分
    double? y;
    if (d <= 0.5) {
      y = 2 * d;
    } else {
      y = 1 - 2 * (d - 0.5);
    }
    return y;
  }

}
