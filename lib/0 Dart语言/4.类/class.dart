
// Dart 是一种基于类和 mixin 继承机制的面向对象的语言。 每个对象都是一个类的实例

// 如何使用类
// 1.创建对象————>使用构造函数：通过 构造函数 创建对象。 构造函数的名字可以是 ClassName 或者 ClassName.identifier。
// 2.使用类的成员变量 .成员变量。使用 ?. 来代替 . ， 可以避免因为左边对象可能为 null ， 导致的异常
// 3.获取对象的类型，使用：runtimeType ,返回一个 Type 对象
void main(){
  IsCase iscase = IsCase(1,2);
  print("iscsi-i:${iscase.i}");
  print("iscsi-j:${iscase.j}");
  IsCase iscase2 = IsCase.forName(90, 20);
  print("iscsi-i:${iscase2.i}");
  print("iscsi-j:${iscase2.j}");
}

// 如何实现类
/* 1. 实例变量
 * 2. 构造函数 */
class IsCase{
  /*1.实例变量
   * 未初始化实例变量的默认人值为 “null”
   * 所有实例变量都有隐式getter方法，非final变量都有隐式setter方法 */
  late num _ii;

  num get ii => _ii;

  set ii(num value) {
    _ii = value;
  }

  late int i ;
  late int j ;
  /* 1、在没有声明构造函数的情况下， Dart 会提供一个默认的构造函数(匿名函数 + 无参数)，它会调用父类的无参构造函数。
        如果父类中没有匿名无参的构造函数， 则需要手工调用父类的其他构造函数。 在当前构造函数冒号 (:) 之后，函数体之前，声明调用父类构造函数。
   * 2、在声明构造函数之后，默认构造函数将不存在，除非再显示的调用他
   * 3、使用命名构造函数，可以为一个类实现多个构造函数*/
  //在没有声明构造函数的情况下， Dart 会提供一个默认的构造函数。 默认构造函数没有参数并会调用父类的无参构造函数。
  // dart语法糖
  /*IsCase(i,j,ii){
    this.i = i;
    this.j = j;
    this.ii = ii;
  }*/
  IsCase(this.i, this.j);


  /* 命名构造函数 */
  // 构造函数的名字 ClassName.identifier
  IsCase.forName(this.i,this.j);
  IsCase.forSet(){
    i = 100;
    j = 900;
  }

}