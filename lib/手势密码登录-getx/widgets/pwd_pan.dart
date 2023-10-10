import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../手势密码登录/point.dart';
import '../../手势密码登录/point_view.dart';

// 密码盘绘制 - 在此处画 9 个圆
class PwdPan extends StatefulWidget {

  final double size; /* 密码盘大小*/
  final Color selectColor ; /* 选中颜色 */
  final Color unSelectColor; /* 未选中颜色 */
  final double ringWidth;
  final double ringRadius;
  final double circleRadius;
  final double lineWidth;
  final bool showUnSelectRing;
  final bool immediatelyClear;
  List<Point> points = [];
  final Function() onPanDown;
  final Function(List<int>) onPanUp;


  PwdPan({
    Key? key,
    required this.size,
    this.selectColor = Colors.blue,
    this.unSelectColor = Colors.grey,
    this.ringWidth = 4, /* 外圆的宽度 */
    this.ringRadius = 30, /* 外圆的半径 */
    this.showUnSelectRing = true,
    this.circleRadius = 10, /* 内圆的半径*/
    this.lineWidth = 6, /* 连接线的宽度 */
    required this.onPanUp,
    required this.onPanDown,
    this.immediatelyClear = false
  }): super(key: key){

    final realRingSize = ringRadius + ringWidth/2;
    final gapWidth = size/6 - realRingSize;
    for (int i = 0 ; i < 9 ; i++) {
      double x = gapWidth + realRingSize;
      double y = gapWidth + realRingSize;
      // 计算每个点的相对位置
      points.add(Point(
          x: (1+i%3*2)*x,
          y: (1+i~/3*2)*y,
          position: i
      ));
    }
  }
  @override
  State<PwdPan> createState() {
    return PwdPanState(
        size: size,
        ringWidth:  ringWidth,
        ringRadius: ringRadius,
        showUnSelectRing: showUnSelectRing,
        circleRadius: circleRadius,
        selectColor: selectColor,
        unSelectColor: unSelectColor,
        points: points,
        lineWidth: lineWidth,
        onPanDown: onPanDown,
        onPanUp: onPanUp,
        immediatelyClear: immediatelyClear
    );
  }
}

class PwdPanState extends State<PwdPan> {

  final double size;
  final double ringWidth;
  final double ringRadius;
  final bool showUnSelectRing;
  final double circleRadius;
  Color selectColor; // open only
  final Color unSelectColor;
  final double lineWidth;
  final List<Point> points; // 所有圆点
  final Function() onPanDown;
  final Function(List<int>) onPanUp;
  final List<Point> pathPoints = [];
  double realRadius = 0;
  Point curPoint = Point(x: -1, y: -1, position: -1) ;
  final bool immediatelyClear;

  PwdPanState({
    required this.size,
    required this.selectColor,
    required this.unSelectColor,
    required  this.ringWidth,
    required this.ringRadius,
    required this.showUnSelectRing,
    required this.circleRadius,
    required this.points,
    required this.lineWidth,
    required this.onPanDown,
    required this.onPanUp,
    required this.immediatelyClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: Size(this.size, this.size),
        painter: PointView(
            ringWidth: ringWidth,
            ringRadius: ringRadius,
            showUnSelectRing: showUnSelectRing,
            circleRadius: circleRadius,
            selectColor: selectColor,
            unSelectColor: unSelectColor,
            points: points
        ),
      ),
    );
  }
}
