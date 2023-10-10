import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/point.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95/point_view.dart';
import 'line_view.dart';


// 绘制密码盘
class GestureView extends StatefulWidget {

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
  State<GestureView> createState() {
    return GestureViewState(
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

class GestureViewState extends State<GestureView> {

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
    realRadius = ringRadius+ringWidth/2;
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: <Widget>[
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
                ringWidth: ringWidth,
                ringRadius: ringRadius,
                showUnSelectRing: showUnSelectRing,
                circleRadius: circleRadius,
                selectColor: selectColor,
                unSelectColor: unSelectColor,
                points: points
            ),
          ),
        ),
        // 刷新密码线
        /* 手势有三种状态
         * 按下 onPanDown
         * 移动 onPanUpdate
         * 抬起 onPanEnd */
        GestureDetector(
          onPanDown: _onPanDown,
          onPanUpdate: (DragUpdateDetails e) => _onPanUpdate(e,context),
          onPanEnd: (DragEndDetails e) => _onPanEnd(e,context),
          child: CustomPaint(
            size: Size(size, size),
            painter: LineView(
                pathPoints: pathPoints,
                selectColor: selectColor,
                lineWidth: lineWidth,
                curPoint: curPoint
            ),
          ),
        ),
      ],
    );
  }

  // 按下方法
  _onPanDown(DragDownDetails e) {
    _clearAllData();
    print("按下");
    onPanDown();
  }

  // 移动方法
  _onPanUpdate(DragUpdateDetails e,BuildContext context) {

    /*获取用户在屏幕上的点击位置，并将其转换为相对于当前组件的坐标系中的偏移量*/
    /*context.findRenderObject() 用于获取当前组件的渲染对象，即 RenderBox*/
    /*box.globalToLocal(e.globalPosition) 则用于将全局坐标系中的点击位置转换为相对于当前组件的坐标系中的偏移量*/

    RenderObject? box = context.findRenderObject() as RenderBox;
    if (box is RenderBox) {
      Offset offset = box.globalToLocal(e.globalPosition);
      _slideDealt(offset);
      setState(() {
        curPoint = Point(x: offset.dx, y: offset.dy,position: -1);
      });
    }
  }

  // 抬起方法
  _onPanEnd(DragEndDetails e,BuildContext context ){
    print("我抬起了");

    /* 如果路径不为空
     * 则，更新当前最后的那个圆点*/
    if (pathPoints.isNotEmpty) {
      setState(() {
        curPoint = pathPoints[pathPoints.length - 1];
      });
      /* 处理当前路径圆点的索引，将其转换成int 类型的列表*/
      List<int> items = pathPoints.map((e) => e.position).toList();
      onPanUp(items);
      if (immediatelyClear) _clearAllData(); //clear data
    }

  }

  // 滑动处理圆点
  _slideDealt(Offset offSet) {

    /* xPosition 和 yPosition 分别表示当前偏移量所在的列和行的索引，初始值为 -1。
     * for 循环会遍历 0-2 3行3列*/
    int xPosition = -1;
    int yPosition = -1;
    for (int i = 0 ; i < 3 ; i++) {
      /* 判断条件
       * 1、xPosition == -1 此时，行还未找到
       * 2、偏移量的 x 坐标在当前点的范围内（即 points[i].x-realRadius 到 points[i].x+realRadius 之间*/
      if (xPosition == -1 && points[i].x+realRadius >= offSet.dx && offSet.dx >= points[i].x-realRadius) {
        xPosition = i;
      }
      if (yPosition == -1 && points[i*3].y+realRadius >= offSet.dy && offSet.dy >= points[i*3].y - realRadius) {
        yPosition = i;
      }
    }
    /*如果 xPosition 或 yPosition 的值仍为 -1，则说明偏移量不在任何一个点的范围内，直接返回*/
    if (xPosition == -1 || yPosition == -1) return;
    /*否则，根据列和行的索引计算出该点在九宫格中的位置，并将其索引赋值给 position 变量*/
    /* 索引和行和列的关系
     * 列 *3 + 行
     * 索引 8 = 2*3 + 2*/
    int position = yPosition*3+xPosition;
    /* 如果当前索引所对应的点已经被选择 则修改其颜色，并将其加入到 pathPoints 路径圆点中*/
    if (!points[position].isSelect) {
      points[position].isSelect = true;
      pathPoints.add(points[position]);
    }
  }

  // 清空路径圆点
  _clearAllData() {
    for (int i = 0 ; i < 9 ; i++) {
      points[i].isSelect = false;
    }
    pathPoints.clear();
    setState(() {}); // 刷新
  }
}
