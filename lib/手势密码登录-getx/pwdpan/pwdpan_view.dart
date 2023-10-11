import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../手势密码登录/line_view.dart';
import '../../手势密码登录/point_view.dart';
import 'pwdpan_logic.dart';

class PwdpanPage extends StatelessWidget {
  const PwdpanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PwdpanLogic());
    final state = Get.find<PwdpanLogic>().state;

    logic.set(context);

    return GetBuilder<PwdpanLogic>(builder: (logic) {
      return Stack(
        children:<Widget> [
          // 绘制圆圈
          CustomPaint(
            size: Size(state.size, state.size),
            painter: PointView(
                ringWidth: state.ringWidth,
                ringRadius: state.ringRadius,
                showUnSelectRing: state.showUnSelectRing,
                circleRadius: state.circleRadius,
                selectColor: state.selectColor,
                unSelectColor: state.unSelectColor,
                points: state.points
            ),
          ),
          GestureDetector(
            onPanDown: (DragDownDetails e)=>logic.onPanDown(e, context),
            onPanUpdate: (DragUpdateDetails e)=>logic.onPanUpdate(e, context),
            onPanEnd: (DragEndDetails e)=>logic.onPanEnd(e, context),
            child: CustomPaint(
              size: Size(state.size, state.size),
              painter: LineView(
                  pathPoints: state.pathPoints,
                  selectColor: state.selectColor,
                  lineWidth: state.lineWidth,
                  curPoint: state.curPoint
              ),
            ),
          ),
        ],
      );
    });
  }
}
