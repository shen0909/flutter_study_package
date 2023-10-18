import 'dart:ui';
import 'package:flutter/material.dart';
import '../../手势密码登录/point.dart';
import '../widgets/pwd_pan.dart';

class GgestureState {
  //—————— 圆点 ————————
  List<Point> pathPoints = []; // 路径圆点集合
  final List<Point> points = []; // 所有圆点
  late Point curPoint ; // 当前的鼠标所指的点

  //—————— 密码 ————————
  List<int> inPwd = []; //输入的密码
  List<int> setPwd = []; //设置的密码
  int inNum = 5; // 输入密码次数 默认为5
  int setNum = 0; // 设置密码次数 默认为0

  //—————— 动画 ————————
  String textTip = "请绘制手势密码"; // 提示信息
  Color textColor = Colors.black;
  late AnimationController animationController;
  late Animation<double> animationMag;
  late Animation<Color?> animationColor;
  late BuildContext context;

  GlobalKey<PwdPanState> PwdPanStateKey = GlobalKey();

  GgestureState() {
  }
}
