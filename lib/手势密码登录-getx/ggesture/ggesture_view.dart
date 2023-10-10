import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/pwd_pan.dart';
import 'ggesture_logic.dart';

class GgesturePage extends StatelessWidget {
  const GgesturePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(GgestureLogic());
    final state = Get.find<GgestureLogic>().state;
    double size = MediaQuery.of(context).size.width * 0.8;

    return GetBuilder<GgestureLogic>(builder: (logic) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.textTip,style: TextStyle(fontSize: 20,color: state.textColor),),
          const SizedBox(height: 20,),
          // 绘制密码盘
          Center(
            child: Container(
              color: Colors.amber,
              /* PwdPan 封装的密码盘绘制 类*/
              child: PwdPan(
                key:state.PwdPanStateKey,
                size: size,
                onPanUp: (List<int> items) {  },
                onPanDown: () {  },
              ),
            ),
          )
        ],
      );
    });
  }
}
