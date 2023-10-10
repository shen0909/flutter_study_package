import 'package:flutter/material.dart';
import 'ggesture/ggesture_view.dart';

class GMainPage extends StatelessWidget {
  const GMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("手势登录-getx"),
      ),
      body: const GgesturePage(),
    );
  }
}
