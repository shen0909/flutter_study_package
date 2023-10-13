void main() {

  // 异常例子1
  errorCase1();


  // 异常例子2
  try{
    checkErro(23);
  }on numNot catch(e){
    print("错误信息:${e.errMsg()}");
  }

}

// 异常例子1
void errorCase1(){
  int x = 12;
  int y = 0;
  int res = 0;
  try {
    res = x ~/ y;
  } on IntegerDivisionByZeroException {
    print('不能除以零'); // output：不能除以零
  } catch (e) {
    print(e);
  } finally {
    print("总是执行，不顾异常");
  }
}

void checkErro(int a){
  if(a <100){
    throw numNot();
  }
}

// 自定义异常
class numNot implements Exception {
  String errMsg() => "数字不能<100";
}