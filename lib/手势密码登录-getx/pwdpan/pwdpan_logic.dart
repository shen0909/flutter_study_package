import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95-getx/common/eventbus.dart';
import 'package:get/get.dart';
import '../../11 动画/page.dart';
import '../../手势密码登录/point.dart';
import '../ggesture/ggesture_logic.dart';
import 'pwdpan_state.dart';

class PwdpanLogic extends GetxController {


  final PwdpanState state = PwdpanState();
  final gestureLogic = Get.find<GgestureLogic>();


  @override
  void onInit() {
    super.onInit();

    // state.onPanUp = gestureLogic.setPwd(state.getIndex);

    // 监听事件
    eventBusG.on<EventSuccessSetPwd>().listen((event) {
      print("设置密码的情况:${event.success}");
      bool suc = event.success;
      state.setSuc = event.success;
      // 此时密码设置成功时，不用在设置密码,否则,通知Getsture 需要重新设置密码
      if(!suc){
        // state.onPanUp = gestureLogic.setPwd(state.getIndex);
        eventBusG.fire(EventSetPwd());
      }
    });

  }

  // 设置数据
  set(BuildContext context){
    state.size = MediaQuery.of(context).size.width * 0.8;
    final realRingSize = state.ringRadius + state.ringWidth / 2;
    final gapWidth = state.size / 6 - realRingSize;
    state.realRadius = state.ringRadius + state.ringWidth/2;

    for (int i = 0; i < 9; i++) {
      double x = gapWidth + realRingSize;
      double y = gapWidth + realRingSize;
      // 计算每个点的相对位置
      state.points.add(Point(
          x: (1 + i % 3 * 2) * x,
          y: (1 + i ~/ 3 * 2) * y,
          position: i
      ));
    }
    update();
  }

  // 按下方法-----初始化
  /* 1、修改选中颜色
   * 2、文字提醒
   * 3、清空路径圆点
   * 4、如果按下时，输入次数已用完则修改文字提醒并抖动*/
  onPanDown(DragDownDetails e,BuildContext context){
    print("按下");
    _clearAllData();
    // 由于，设置错误时，提示字母的颜色是红色，而每次按下都是新的开始，所以要初始化到黑色
    gestureLogic.state.textColor = Colors.black;
  }

  // 移动时
  /* 当输入达到上限时，不可用*/
  onPanUpdate(DragUpdateDetails e,BuildContext context){
    /*获取用户在屏幕上的点击位置，并将其转换为相对于当前组件的坐标系中的偏移量*/
    /*context.findRenderObject() 用于获取当前组件的渲染对象，即 RenderBox*/
    /*box.globalToLocal(e.globalPosition) 则用于将全局坐标系中的点击位置转换为相对于当前组件的坐标系中的偏移量*/

    RenderObject? box = context.findRenderObject() as RenderBox;
    if (box is RenderBox) {
      Offset offset = box.globalToLocal(e.globalPosition);
      _slideDealt(offset);
      state.curPoint = Point(x: offset.dx, y: offset.dy,position: -1);
    }
    update();
  }

  // 抬起时，传回密码索引，更新当前点
  onPanEnd(DragEndDetails e,BuildContext context){
    print("抬起");
    /* 如果路径不为空
     * 则，更新当前最后的那个圆点、处理索引*/
    if (state.pathPoints.isNotEmpty) {
      state.curPoint = state.pathPoints[state.pathPoints.length - 1];
      /* 处理当前路径圆点的索引，将其转换成int 类型的列表*/
      state.getIndex = state.pathPoints.map((e) => e.position).toList();
      // 密码设置不成功
      if(!state.setSuc) {
        gestureLogic.setPwd(state.getIndex);
      }
      // 密码设置成功- 判断密码正确
      /* 根据 返回的判断密码正确 的结果，决定是否跳转*/
      else{
        if(gestureLogic.checkResult(state.getIndex)){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                return const AnimationPages();
              }));
        }
      }
      if (state.immediatelyClear) _clearAllData(); //clear data
      update();
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
      if (xPosition == -1 && state.points[i].x+state.realRadius >= offSet.dx && offSet.dx >= state.points[i].x-state.realRadius) {
        xPosition = i;
      }
      if (yPosition == -1 && state.points[i*3].y+state.realRadius >= offSet.dy && offSet.dy >= state.points[i*3].y - state.realRadius) {
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
    if (!state.points[position].isSelect) {
      state.points[position].isSelect = true;
      state.pathPoints.add(state.points[position]);
    }
    update();
  }

  // 清空路径圆点
  _clearAllData() {
    for (int i = 0 ; i < 9 ; i++) {
      state.points[i].isSelect = false;
    }
    state.pathPoints.clear();
    update();
  }
}
