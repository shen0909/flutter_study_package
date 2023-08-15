import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoAppOne extends StatefulWidget {

  @override
  State<LogoAppOne> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoAppOne> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #docregion addListener
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        // #enddocregion addListener
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
        // #docregion addListener
      });
    // #enddocregion addListener
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("动画例1"),),
      body: Container( child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        ),
      ),),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}