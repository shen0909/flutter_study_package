import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pwdpan/pwdpan_view.dart';
import 'ggesture_logic.dart';

class GgesturePage extends StatelessWidget {
  const GgesturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GgestureLogic());
    final state = Get.find<GgestureLogic>().state;

    return GetBuilder<GgestureLogic>(builder: (logic) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: state.animationMag,
              builder: (context, child) {
                return Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      left: logic.errorPwd() * 110,
                      right: state.animationMag.value,
                    ),
                    child: Text(
                      state.textTip,
                      style: TextStyle(fontSize: 20, color: state.textColor),
                    ));
              }),
          const SizedBox(height: 20),
          // 绘制密码盘
          const Center(child: PwdpanPage()),
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
}
