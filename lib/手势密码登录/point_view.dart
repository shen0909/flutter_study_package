import 'package:flutter/cupertino.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/point.dart';

// 绘制圆点
class PointView extends CustomPainter{

  final double ringWidth;
  final double ringRadius;
  final bool showUnSelectRing;
  final double circleRadius;
  final Color selectColor;
  final Color unSelectColor;
  final List<Point> points;

  PointView({
    required this.ringWidth,
    required this.ringRadius,
    required this.showUnSelectRing,
    required this.circleRadius,
    required this.selectColor,
    required this.unSelectColor,
    required this.points
  });

  /* CustomPainter中定义了一个虚函数paint
   * Canvas：各种不同的绘画方法
   * Size：当前区域大小*/
  @override
  void paint(Canvas canvas, Size size) {
    /* 创建一个画笔，并配置属性
     * isAntiAlias 是否抗锯齿
     * style 画笔样式
     * color 画笔颜色*/
    final ringPaint = Paint()
      ..isAntiAlias = true
      ..color  = unSelectColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth;

    final circlePaint = Paint()
      ..isAntiAlias = true
      ..color  = unSelectColor
      ..style = PaintingStyle.fill;

    // 绘制9个圆
    for(int i = 0; i < points.length; i++){

      final point = points[i];

      //将一个给定的二维坐标点（point）转换为Flutter中使用的偏移量（Offset）
      final offset = Offset(point.x, point.y);

      // 根据圆点是否选择，确定绘画的颜色
      final color = point.isSelect ? selectColor : unSelectColor;
      circlePaint.color = color;
      ringPaint.color = color;
      // 内部圆圈
      canvas.drawCircle(offset, circleRadius, circlePaint);

      if (showUnSelectRing || point.isSelect) {
        canvas.drawArc(
            Rect.fromCircle(center: offset,radius: ringRadius),
            0, 360, false, ringPaint
        );
      }
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}