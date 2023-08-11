import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusMain extends StatefulWidget {
  @override
  State<FocusMain> createState() => _FocusMainState();
}

class _FocusMainState extends State<FocusMain> {
  FocusNode fNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode userNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode frNode = FocusNode();
  FocusNode repasswordNode = FocusNode();
  FocusNode remailNode = FocusNode();
  FocusNode ruserNode = FocusNode();
  FocusNode rpasswordNode = FocusNode();
  FocusNode rrepasswordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(fNode);
    // print("FocusScope.of(context).hasPrimaryFocus;${FocusScope.of(context).hasPrimaryFocus}");
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            FocusScope(
              autofocus: true,
              child: Focus(
                // autofocus: true,
                focusNode: fNode,
                onKey: (node, event) {
                  if (event is RawKeyDownEvent) {
                    print("下键");
                    if (userNode.hasFocus) {
                      setState(() => passwordNode.requestFocus());
                    }
                    if (emailNode.hasFocus) {
                      setState(() => emailNode.requestFocus());
                    }
                    if (passwordNode.hasFocus) {
                      setState(() => emailNode.nextFocus());
                    }
                  }
                  return KeyEventResult.handled;
                },
                child: Column(
                  children: [
                    TextField(
                      focusNode: userNode,
                      autofocus: true,
                      decoration: InputDecoration(hintText: "用户名"),
                    ),
                    TextField(
                      focusNode: passwordNode,
                      decoration: InputDecoration(hintText: "密码"),
                    ),
                    TextField(
                      focusNode: emailNode,
                      decoration: InputDecoration(hintText: "邮箱"),
                    ),
                    TextField(
                      focusNode: repasswordNode,
                      decoration: InputDecoration(hintText: "再次输入密码"),
                    ),
                  ],
                ),
              ),
            ),
            /*SizedBox(height: 30,),
            FocusScope(
                autofocus: true,
                child: RawKeyboardListener(
                  onKey: (RawKeyEvent event){
                    if(event.logicalKey==LogicalKeyboardKey.enter){
                      print("press enter");
                      if (ruserNode.hasFocus) {
                        print("press enter!!");
                        setState(()=>rpasswordNode.requestFocus());
                      }
                    }
                  },
                  focusNode: frNode,
                  child: Column(
                    children: [
                      TextField(
                        focusNode: ruserNode,
                        autofocus: true,
                        decoration: InputDecoration(hintText: "用户名"),
                      ),
                      TextField(
                        focusNode: rpasswordNode,
                        decoration: InputDecoration(hintText: "密码"),
                      ),
                      TextField(
                        focusNode: remailNode,
                        decoration: InputDecoration(hintText: "邮箱"),
                      ),
                      TextField(
                        focusNode: rrepasswordNode,
                        decoration: InputDecoration(hintText: "再次输入密码"),
                      ),
                    ],
                  ),
                ))*/
          ],
        ),
      ),
    );
  }
}
