class getterSingleton{

  //静态属性——该类的实例
  static getterSingleton? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化(也可以不单独创建构造函数，直接使用默认的无参构造函数————>commonSingleton())
  getterSingleton._internal();

  //通过静态方法getInstance()访问实例,getInstance()通常是静态方法
  /*如果实例存在则返回该实例，如果不存在则调用私有命名构造方法构造一个实例*/
  static get instance {
    if(_instance==null){
      // _instance=commonSingleton();
      _instance=getterSingleton._internal();
    }
    return _instance!;
  }
  //属性
  String text="这是一个Dart化的单例模式，使用getter操作符";
}