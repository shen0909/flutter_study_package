void main() {

  // 异常例子1
  errorCase1();


  // 异常例子2
  try{
    checkErro(23);
    checkErroSt("曹纹浩");
  }on NumNot catch(e){
    print("错误信息:${e.errMsg()}");
  }catch(e){
    print("第二个捕捉:${e.toString()}");
  }

}

// 异常例子1
void errorCase1(){
  int x = 12;
  int y = 0;
  try {
    x ~/ y;
  } on IntegerDivisionByZeroException {
    print('不能除以零'); // output：不能除以零
  } catch (e) {
    print(e);
  } finally {
    print("总是执行，不顾异常");
  }
}

// 可能错误1
void checkErro(int a){
  if(a <100){
    throw NumNot();
  }
}

// 可能错误2
void checkErroSt(String str){
  if(str != "沈成林"){
    throw StringNot();
  }
}

// 自定义异常1
class NumNot implements Exception {
  String errMsg() => "数字不能<100";
}

// 自定义异常2
class StringNot implements Exception{

  @override
  String toString() => "文字错误";
}