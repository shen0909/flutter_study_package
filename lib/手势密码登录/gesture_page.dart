import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gesture_view.dart';

class GesturePage extends StatefulWidget {
  const GesturePage({Key? key}) : super(key: key);

  @override
  State<GesturePage> createState() => _GesturePageState();
}

class _GesturePageState extends State<GesturePage> {

  //最后密码
  List<int> curResult = [];
  GlobalKey<GestureViewState> gestureStateKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("请输入手势密码",style: TextStyle(fontSize: 20,)),
        /* 输入的手势密码 */
        /*Container(
          height: 60,
          child: Center(
            child: Text(
              "Current: ${curResult.toString()}",
              style: TextStyle(fontSize: 24,color: Colors.blue),
            ),
          ),
        ),*/
        Center(
          child: GestureView(
            key: this.gestureStateKey,
            size: MediaQuery.of(context).size.width*0.8,
            selectColor: Colors.blue,
            onPanUp: (List<int> items) {
              // analysisGesture(items);
              print("------");
            },
            onPanDown: () {
              print("结束");
              gestureStateKey.currentState?.selectColor = Colors.blue;
              setState(() {
                // status = 0;
              });
            },
          ),
        ),
      ],
    );
  }
}