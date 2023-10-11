import 'package:flutter/material.dart';
import '../../手势密码登录/point.dart';

class PwdpanState {

  late  double size = 0; /* 密码盘大小*/
  Color selectColor = Colors.blue; /* 选中颜色 */
  Color unSelectColor = Colors.grey; /* 未选中颜色 */
  final double ringWidth = 4;
  final double ringRadius = 30;
  final double circleRadius = 10;
  final double lineWidth = 6;
  double realRadius = 0;
  final bool showUnSelectRing = true;
  final bool immediatelyClear = true;
  List<Point> pathPoints = []; // 路径圆点集合
  final List<Point> points = []; // 所有圆点
  late Point curPoint = Point(x: -1, y: -1, position: -1) ; // 当前的鼠标所指的点
  late final Function() onPanDown;
  late final Function(List<int>) onPanUp;

  //密码设置成功
  bool setSuc = false;
  List<int> getIndex = [];

  PwdpanState() {
    ///Initialize variables
  }
}
