import 'package:flutter/cupertino.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/point.dart';

// 线条属性
/* 线条的长度 = 路径圆点的个数 - 1*/
class LineView extends CustomPainter{

  final List<Point> pathPoints; /* 路径圆点*/
  final Color selectColor;
  final double lineWidth;
  final Point curPoint;


  LineView({
    required this.pathPoints,
    required this.selectColor,
    required this.lineWidth,
    required this.curPoint
  });

  @override
  void paint(Canvas canvas, Size size) {
    int length = pathPoints.length;
    if (length < 1) return;

    /* 线条画笔 */
    final linePaint = Paint()
      ..isAntiAlias = true
      ..color  = selectColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = lineWidth;

    for(int i = 0; i< length -1; i++){
      canvas.drawLine(
          Offset(pathPoints[i].x, pathPoints[i].y),
          Offset(pathPoints[i+1].x, pathPoints[i+1].y),
          linePaint
      );
    }

    // 鼠标悬浮时的线条
    /* 获取当前点的坐标，并将其分别赋值给 endX 和 endY 变量
     * 检查 endX 和 endY 是否超出了画布的范围。如果超出了画布的左边界或上边界，则将其设置为 0；
     * 如果超出了画布的右边界或下边界，则将其设置为画布的宽度或高度 */
    double endX = curPoint.x;
    double endY = curPoint.y;
    if (endX < 0) {
      endX = 0;
    } else if (endX > size.width) {
      endX = size.width;
    }
    if (endY < 0) {
      endY = 0;
    } else if (endY > size.height){
      endY = size.height;
    }

    /* 起点是 pathPoints 列表中最后一个点的坐标，终点是当前点的坐标 */
    canvas.drawLine(
        Offset(pathPoints[length - 1].x, pathPoints[length - 1].y),
        Offset(endX, endY),
        linePaint
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}