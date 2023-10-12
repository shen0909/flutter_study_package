void main(){
//  1、dart和Java都支持常用的算术运算符
//  2、dart中的某些运算符有不同的功能
/* 2.1 ??可以用于空值检测，Java中没有。expr1 ?? expr2 。如果 expr1 是 non-null， 返回 expr1 的值； 否则, 执行并返回 expr2 的值。
 * 2.2 Dart中的“~/”运算符可以用于执行整数除法并返回整数结果，而Java中的除法运算符将始终返回浮点结果。
 * 2.3 级联运算符 ..（是dart的一个特殊语法），可以对同一个对象做多次操作,但不能在void对象上创建级联操作。ps:级联运算符可以嵌套
 * 2.4 dart中有空安全，变量可以是空值或者非空值
 * 2.5 dart中的类型判定运算符和Java不同。dart：as、is、is!; Java：instanceof
 *    使用 as 运算符将对象强制转换为特定类型
 * */

  var i = "使用as";
  if( i is String){
    print("i的类型：${i.runtimeType}");
  }

//  流程控制语句
  List<int> items = [1,2,3,4,5,6];
  // for 循环
  /* 1.标准for循环
   * 2.如果要迭代一个实现了 Iterable 接口的对象， 可以使用 forEach() 方法。它不支持跳出循环。也可以使用 for-in*/
  items.forEach((element) {
    if(element > 3)
    {
      print(">3:$element");
    }
  });

  for (var element in items) {
    if(element > 3)
      {
        print(">3:$element");
        break;
      }
  }

  // break：停止循环，continue：结束本次，跳转到下次
  // dart和Java的 switch和case 基本相同，但Java中case语句的值必须是常量，在Flutter中，case语句的值可以是任何类型，包括字符串和对象。
  // 如果 assert 语句中的布尔条件为 false ， 那么正常的程序执行流程会被中断。assert 的第二个参数可以为其添加一个字符串消息。
  // assert 的第一个参数可以是解析为布尔值的任何表达式。 如果表达式结果为 true ， 则断言成功，并继续执行。 如果表达式结果为 false ， 则断言失败，并抛出异常 (AssertionError) 。
  

}