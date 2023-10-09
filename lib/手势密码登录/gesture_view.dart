import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/point.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/point_view.dart';


// 绘制密码盘
class GestureView extends StatefulWidget {

  final double size; /* 密码盘大小*/
  final selectColor;
  final unSelectColor;
  final double ringWidth;
  final double ringRadius;
  final double circleRadius;
  final double lineWidth;
  final bool showUnSelectRing;
  final bool immediatelyClear;
  List<Point> points = [];
  final Function() onPanDown;
  final Function(List<int>) onPanUp;

  GestureView({
    Key? key,
    required this.size,
    this.selectColor = Colors.blue,
    this.unSelectColor = Colors.grey,
    this.ringWidth = 4,
    this.ringRadius = 30,
    this.showUnSelectRing = true,
    this.circleRadius = 20,
    this.lineWidth = 6,
    required this.onPanUp,
    required this.onPanDown,
    this.immediatelyClear = false
  }): super(key: key){

    final realRingSize = this.ringRadius + this.ringWidth/2;
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
  State<GestureView> createState() {
    return GestureViewState(
        size: this.size,
        ringWidth: this.ringWidth,
        ringRadius: this.ringRadius,
        showUnSelectRing: this.showUnSelectRing,
        circleRadius: this.circleRadius,
        selectColor: this.selectColor,
        unSelectColor: this.unSelectColor,
        points: this.points,
        lineWidth: this.lineWidth,
        onPanDown: this.onPanDown,
        onPanUp: this.onPanUp,
        immediatelyClear: this.immediatelyClear
    );
  }
}

class GestureViewState extends State<GestureView> {

  final double size;
  final double ringWidth;
  final double ringRadius;
  final bool showUnSelectRing;
  final double circleRadius;
  Color selectColor; // open only
  final Color unSelectColor;
  final double lineWidth;
  final List<Point> points;
  final Function() onPanDown;
  final Function(List<int>) onPanUp;
  final List<Point> pathPoints = [];
  double realRadius = 0;
  Point? curPoint ;
  final bool immediatelyClear;

  GestureViewState({
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
  void initState() {
    super.initState();
    realRadius = this.ringRadius+ringWidth/2;
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        /* CustomPaint:
           * painter: 背景画笔，会显示在子节点后面；
           * 子节点可以为空，如果CustomPaint有子节点，为了避免子节点不必要的重绘并提高性能，通常情况下都会将子节点缠绕在组件中RepaintBoundary
           * foregroundPainter: 前景画笔，会显示在子节点前面
           * size：当child为null时，代表默认稀疏区域大小，如果有child则忽略此参数
           * 画笔需要继承类CustomPainter，我们在画笔类中实现真正的不同逻辑*/
        Container(
          child: CustomPaint(
            size: Size(this.size, this.size),
            painter: PointView(
                ringWidth: this.ringWidth,
                ringRadius: this.ringRadius,
                showUnSelectRing: this.showUnSelectRing,
                circleRadius: this.circleRadius,
                selectColor: this.selectColor,
                unSelectColor: this.unSelectColor,
                points: points
            ),
          ),
        ),
        // 刷新密码线

      ],
    );
  }
}
