import 'package:flutterapp/%E6%95%B0%E6%8D%AE%E5%AD%98%E5%82%A8/%E6%9C%AC%E5%9C%B0%E6%95%B0%E6%8D%AE%E5%BA%93/DB_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../本地数据库/model.dart';

main() async {
  //初始化数据库
  /*后面进行数据操作时,会自动初始化数据,所以这里可以不用初始化数据库*/
  // await DBHelp.getInstance().initDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Windows 数据库封装",
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatefulWidget {
  @override
  State<HYHomePage> createState() => _HYHomePageState();
}

class _HYHomePageState extends State<HYHomePage> {
  TextEditingController idController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();
  List<Model> model = [Model(10, "content"), Model(10, "content")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Windows 数据库封装"),
      ),
      body: Center(
        child: Container(
            child: Column(
          children: [
            Container(
              width: 300,
              child: TextField(
                controller: idController,
                decoration: InputDecoration(hintText: "请输入 id"),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: contentController,
                decoration: InputDecoration(hintText: "请输入 内容"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: Text("提交")),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              width: 300,
              decoration: BoxDecoration(color: Colors.yellow),
              alignment: Alignment.center,
              child: Text(
                "展示",
              ),
            ),
            Container(
              width: 500,
              height: model.length * 30,
              child: ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (content, index) {
                    return Container(
                      height: 30,
                      child: Row(
                        children: [
                          Text("id:${model[index].id}"),
                          SizedBox(
                            width: 20,
                          ),
                          Text("content:${model[index].content}"),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print("删除这条数据");
                                delete(model[index]);
                              },
                              child: Text("删除")),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                print("修改这条数据");
                                modify(model[index]);
                              },
                              child: Text("修改"))
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  getDate();
                },
                child: Text("获取")),
          ],
        )),
      ),
    );
  }

  //提交数据
  submit() async {
    Model model = Model(int.parse(idController.text), contentController.text);
    print("提交数据到数据库");
    await DBHelp.getInstance().insertToDB(model);
  }

  //获取数据
  getDate() async {
    print("获取数据");
    var result = await DBHelp.getInstance().queryDate();
    setState(() => model = result);
  }

  //删除数据
  delete(Model model) async {
    await DBHelp.getInstance().deleteData(model);
    getDate();
  }

  modify(Model model) async {
    await DBHelp.getInstance().modify(model);
    getDate();
  }
}
