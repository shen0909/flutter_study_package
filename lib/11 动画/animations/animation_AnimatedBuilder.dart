import 'package:flutter/material.dart';

class AnimationWithBuilder extends StatefulWidget {

  @override
  State<AnimationWithBuilder> createState() => _State();
}

class _State extends State<AnimationWithBuilder> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50), //变化时间
      lowerBound: 0.0, //被忽略值
      upperBound: 1.0, //已完成值
    );
    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    animation = Tween(begin: 390.0, end: 400.0).animate(animation);
    animation.addListener(() {
      setState(()=>{});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //当动画完成时
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //当动画未完成时，继续向前执行
        animationController.forward();
      }
    });
  }


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("动画_使用AnimatedBuilder简化"),
      ),
      body:BuilderAnimation(animation) ,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          print("执行动画");
          /*点击按钮暂停和开始*/
          if (animationController.isAnimating) {
            animationController.stop();
          } else {
            animationController.forward();
          }
        },
      ),
    );
  }
}

class BuilderAnimation extends StatelessWidget {
  final Animation<double> animation;

  BuilderAnimation(this.animation);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child:Icon(
          Icons.favorite,
          color: Colors.red,
          size: animation.value,
        ) ,
        builder: (context,child){
          return child!;
        });
  }
}

