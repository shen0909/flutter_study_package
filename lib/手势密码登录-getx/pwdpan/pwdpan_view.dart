import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../手势密码登录/line_view.dart';
import '../../手势密码登录/point_view.dart';
import '../ggesture/ggesture_logic.dart';
import 'pwdpan_logic.dart';

class PwdpanPage extends StatelessWidget {
  const PwdpanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(PwdpanLogic());
    final state = Get.find<PwdpanLogic>().state;
    final gestureState = Get.find<GgestureLogic>().state;

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
            // 限制输入次数，输入次数<=0 方法无效
            onPanUpdate: (DragUpdateDetails e) => gestureState.inNum > 0 ? logic.onPanUpdate(e, context):null,
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
