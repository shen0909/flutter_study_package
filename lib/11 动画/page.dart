import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/11%20%E5%8A%A8%E7%94%BB/example/animation2.dart';
import 'Hero动画/hero_animation.dart';
import 'Hero动画/radial_hero_animation.dart';
import 'animations/animation.dart';
import 'animations/animation_AnimatedBuilder.dart';
import 'animations/animation_AnimationWidget.dart';
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimationWithWidget()));
                  },
                  child: Text("简单动画_使用AnimatedWidget简化")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AnimationWithBuilder()));
                  },
                  child: Text("简单动画_使用AnimatedBuilder简化")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HeroAnimation()));
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
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HeroAnimation()));
                  },
                  child: Text("hero动画")),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RadialExpansionDemo()));
                  },
                  child: Text("径向动画")),
            ],
          ),
        ),
      ),
    );
  }
}
