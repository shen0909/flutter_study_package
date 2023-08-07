//普通单例模式
class commonSingleton {

  //静态属性——该类的实例
  static commonSingleton? _instance;

  //私有的命名构造函数，确保类不能从外部被实例化(也可以不单独创建构造函数，直接使用默认的无参构造函数————>commonSingleton())
  commonSingleton._internal();

  //通过静态方法getInstance()访问实例,getInstance()通常是静态方法
  /*如果实例存在则返回该实例，如果不存在则调用私有命名构造方法构造一个实例*/
  static commonSingleton getInstance(){
    if(_instance==null){
      // _instance=commonSingleton();
      _instance=commonSingleton._internal();
    }
    return _instance!;
  }
  //属性
  String text="这是一个普通的单例模式，使用getInstance()方法";
}
