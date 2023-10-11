import 'package:flutter/material.dart';

// 颜色插值器
class ColorAnimation extends StatefulWidget {
  @override
  State<ColorAnimation> createState() => _ColorAnimationState();
}

class _ColorAnimationState extends State<ColorAnimation> with SingleTickerProviderStateMixin{
  late AnimationController animationConroller;
  late Animation<Color?> animation;


  @override
  void initState() {
    animationConroller = AnimationController(vsync: this,duration: const Duration(microseconds: 500))
    ..addListener(() {setState(() {});})
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed ){
        // animationConroller.repeat();
      }
    });

    // 设置动画
    /* 创建了一个CurvedAnimation对象fanimation，
     * 将其作为ColorTween动画的父动画。
     * 然后，我们将curvedAnimation赋值给animation*/
    final fanimation = CurvedAnimation(parent: animationConroller, curve: Curves.bounceIn);
    animation = ColorTween(begin: Colors.amber,end: Colors.red).animate(fanimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            animationConroller.forward();
          },
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
                color: animation.value
            ),
            alignment: Alignment.center,
            child: Text("点我变色",style: TextStyle(fontSize: 20),),
          ),
        ),
      ),
    );
  }
}
