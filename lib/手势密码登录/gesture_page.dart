import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../1 基础widget/key/key.dart';
import 'gesture_view.dart';

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> with SingleTickerProviderStateMixin{

  // 输入的密码
  List<int> curResult = [];
  // 设置的密码
  List<int> settingPsw = [1,2,3];
  GlobalKey<GestureViewState> gestureStateKey = GlobalKey();
  String textTip = "请输入手势密码";
  Color textColor = Colors.black;
  int num = 4;

  /*//———————— 动画 —————————
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 50),
    lowerBound: 0.0, //被忽略值
    upperBound: 1.0,
  );
  late Animation<double> animation = Tween(begin: 0.0, end: 100.0).animate(curvedAnimation)
  ..addListener(() {
    setState(()=>{});
  })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  late CurvedAnimation curvedAnimation = CurvedAnimation(curve: Curves.easeIn, parent: animationController);*/


  /*@override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 提示文字 不断改变文字的边距
        /*AnimatedBuilder(
            animation: animation,
            builder: (c,child){
              return Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  left: _errorPwd() * 110,
                  right: animation.value,
                ),
                child: Text(textTip,style: TextStyle(fontSize: 20,color: textColor),),
              );
            }),*/
        Text(textTip,style: TextStyle(fontSize: 20,color: textColor),),
        Center(
          child: GestureView(
            key: gestureStateKey,
            size: MediaQuery.of(context).size.width*0.8,
            selectColor: Colors.blue,
            // 传入--抬起--方法
            onPanUp: (List<int> items) {
              print("传回来的items是$items");
              // 判断密码是否正确
              _checkPws(items);
            },
            // 传入--按下--方法
            onPanDown: () {
              /* 传入按下时的颜色 - 蓝色*/
              gestureStateKey.currentState?.selectColor = Colors.blue;
              setState(() {
                // status = 0;
                textColor = Colors.black;
                textTip = "请输入手势密码";
              });
            },
          ),
        ),
      ],
    );
  }

  /*// 错误文字的大小
  double _errorPwd(){
    double x = animation.value; // 变化速度 0-10,
    double d = x - x.truncate(); // 获取这个数字的小数部分
    double? y;
    if (d <= 0.5) {
      y = 2 * d;
    } else {
      y = 1 - 2 * (d - 0.5);
    }
    return y;
  }*/
  // 检测密码是否正确
  _checkPws(List<int> items){
    bool isCorrect = true;
  // 长度一样时遍历每个元素是否相等

    if(items.length == settingPsw.length){

      // 如果元素不相等，则解锁失败，
      for(int i = 0;i<items.length;i++){

        if(items[i] != settingPsw[i]){
          isCorrect = false;
          gestureStateKey.currentState?.selectColor = Colors.red;
          print("——————————————密码错误——————————————————");
          setState(() {
            textTip = "密码错误";
            textColor = Colors.red;
          });
          print("输入的密码索引:$items");
          return;
        }
      }
      print("——————————————密码正确——————————————————");
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context){
            return const keyTransfer();
          }));
    }
  // 长度不一样时，直接不正确( 修改选中颜色 打印错误)
    else{
      isCorrect = false;
      print("输入的密码索引:$items");
      print("——————————————密码错误——————————————————");
      setState(() {
        textTip = "密码错误";
        textColor = Colors.red;
      });
      gestureStateKey.currentState?.selectColor = Colors.red;
      return;
    }
  }
}