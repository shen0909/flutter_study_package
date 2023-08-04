//Dart化-工厂构造函数+空安全+箭头函数
class factroySingletonNullJudget{

  static factroySingletonNullJudget? _instance;

  factroySingletonNullJudget._internal(){
    _instance=this;
  }
  factory factroySingletonNullJudget()=> _instance??factroySingletonNullJudget._internal();

  //属性
  String text="这是一个Dart化的单例模式，使用工厂构造函数+空安全+箭头函数";
}