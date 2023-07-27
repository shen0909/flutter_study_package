class factroySingleton{

  //静态属性——该类的实例
  static factroySingleton? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化)
  factroySingleton._internal();

  //工厂构造函数
  factory factroySingleton(){
    if(_instance==null){
      _instance=factroySingleton._internal();
    }
    return _instance!;
  }

  //属性
  String text="这是一个Dart化的单例模式，使用工厂构造函数";
}