import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/11%20%E5%8A%A8%E7%94%BB/example/animation2.dart';
import 'animation.dart';
import 'example/animation1.dart';
import 'example/animation4.dart';
import 'example/animation5.dart';

class AnimationPages extends StatelessWidget {
  const AnimationPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ANIMATIONS"),),
      body: Center(
        child: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimationPage()));
                  },
                  child: Text("简单动画")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogoAppOne()));
                  },
                  child: Text("动画例1")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogoAppTwo()));
                  },
                  child: Text("动画例2")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogoAppFour()));
                  },
                  child: Text("动画例4-使用AnimatedBuilder")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LogoAppFive()));
                  },
                  child: Text("动画例5")),
            ],
          ),
        ),
      ),
    );
  }
}
