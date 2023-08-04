import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileHelp{

  /*getApplicationDocumentsDirectory：此方法返回的是应用程序的文档目录，用于存储用户生成的文件，如用户的文档、设置文件等。
   *这个目录在应用程序被卸载时不会被清除，因此适合存储需要持久保存的数据。*/
  /*getApplicationSupportDirectory：此方法返回的是应用程序的支持目录，用于存储应用程序的支持文件，如日志、缓存文件等。
   *这个目录在应用程序被卸载时可能会被清除，因此不适合存储需要持久保存的数据。*/
  //1、找到正确的本地路径
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("应用文档路径:${directory.path}");
    return directory.path;
  }
  //2、创建一个指向文件位置的引用
  Future<File> get _file async{
    final path = await _localPath;
    print("文件路径:$path/flutter_demo.txt");
    return new File('$path/flutter_demo.txt');
  }

  //3、将数据写入文件
  Future<File> writeFile(String text) async {
    final file = await _file;
    return file.writeAsString('$text' + '\n',mode: FileMode.append);
  }
  //4、从文件读取数据
  Future<String> readCounter() async {
    try {
      final file = await _file;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "这是一个错误";
    }
  }

  //5、判断文件是否存在
  Future<bool> fileExit() async{
    File file= await _file;
    print("file.exists():${file.existsSync()}");
    return file.existsSync();
  }
  //6、如果文件存在，则删除文件
  deletefile() async{
    File file= await _file;
    if(file.existsSync()){
      file.deleteSync();
    }
  }
}