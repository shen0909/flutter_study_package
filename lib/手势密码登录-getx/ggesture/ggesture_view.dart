import 'package:flutter/material.dart';
import 'package:flutterapp/%E6%89%8B%E5%8A%BF%E5%AF%86%E7%A0%81%E7%99%BB%E5%BD%95-getx/ggesture/ggesture_state.dart';
import 'package:get/get.dart';
import '../pwdpan/pwdpan_view.dart';
import 'ggesture_logic.dart';

class GgesturePage extends StatelessWidget {
  const GgesturePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(GgestureLogic());
    final state = Get.find<GgestureLogic>().state;

    return GetBuilder<GgestureLogic>(builder: (logic) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: state.animationMag,
              builder: (context,child){
                return AnimatedBuilder(
                  animation: state.animationColor,
                  builder: (BuildContext context, Widget? child) {
                    return Container(
                        margin:EdgeInsets.only(
                          bottom: 20,
                          left: _errorPwd(state) * 110,
                          right: state.animationMag.value,
                        ) ,
                        child: Text(state.textTip,style: TextStyle(fontSize: 20,color: state.animationColor.value),));
                  },
                );
              }),
          const SizedBox(height: 20,),
          // 绘制密码盘
          const Center(
            child: PwdpanPage(),
          ),
          // Center(
          //   child: Container(
          //     color: Colors.amber,
          //     /* PwdPan 封装的密码盘绘制 类*/
          //     child: PwdPan(
          //       key:state.PwdPanStateKey,
          //       size: size,
          //       onPanUp: (List<int> items) {  },
          //       onPanDown: () {  },
          //     ),
          //   ),
          // )
        ],
      );
    });
  }

  // 错误文字的大小
  double _errorPwd(GgestureState state){
    double x = state.animationMag.value; // 变化速度 0-10,
    double d = x - x.truncate(); // 获取这个数字的小数部分
    double? y;
    if (d <= 0.5) {
      y = 2 * d;
    } else {
      y = 1 - 2 * (d - 0.5);
    }
    return y;
  }
}
