void main(){

  paraN("小杨", 23,"正在做一份程序员的工作\n");

  //————————————————————————函数是一等函数———————————————————————————
  functionTextRegester(
          (){print("这是一个自己写的作为变量的函数");}
  );
  functionText(funtionPara1);
  functionText1(29);
  functionText2(1290);

  //——————————————————————函数可以赋值给一个变量——————————————————————
  void giveFunction(String msg){
    print("函数可以赋值给一个变量，打印的消息是：$msg");
  }
  var getFunctions = giveFunction("把函数赋值给了某个变量");
  void use(){
    getFunctions;
  }

  //————————————————————————————匿名函数————————————————————————————
  var list = ["A","B","C","D"];
  list.forEach((element) {print("这就是个匿名函数，list中的每个元素都会调用这个匿名函数：$element");});


}

void paraN(String name,int age,[String? working]){
  print("$name今年$age,$working");
}

// Dart 是一门真正面向对象的语言， 甚至其中的函数也是对象，并且有它的类型 Function 。
// 这也意味着函数可以被赋值给变量或者作为参数传递给其他函数。 也可以把 Dart 类的实例当做方法来调用。
// 函数的语法糖: => expr 语法是 { return expr; } 的简写。 => 符号 有时也被称为 箭头 语法。
// 此时要求一定要传入一个函数作为参数
void functionText(Function function){
  print("传入的函数的参数为$function");
  function(10);
}

void functionTextRegester(Function function){
  print("传入的函数的参数为$function");
  function();
}

//使用语法糖调用函数
void functionText1(int i ) => funtionPara1(i);

void functionText2(int i ) {
  funtionPara1(i);
}

void funtionPara1(int i){
  print("functionText 要求必须要传入一个函数作为参数，这个函数就是funtionPara1,它的参数是$i");
}

