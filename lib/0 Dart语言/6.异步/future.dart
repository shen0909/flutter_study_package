void main() {
  yibu();
  delayYibu();
  thenYibu();
  errorYibu();
  print("yibu()执行之后打印");
}

Future<void> yibu() async {
  var result = await Future.value(1);
  print("future value :${result}");
}

// 异步延迟
Future<void> delayYibu() async {
  await Future.delayed(const Duration(seconds: 2), () {
    print("Future.delayed 2 seconds.");
  });
}

// then:Future完成时要调用的回调
void thenYibu() {
  Future.value(1).then((value) async {
    var result = await Future.value(value + 2);
    print("then value：${result}");
    return result;
  }).then((value) async {
    var result = await Future.value(value + 2);
    print("then value：${result}");
    return result;
  }).whenComplete(() => print("Future完成之后总是会调用，不管是错误导致的完成还是正常执行完毕"));
}

// 错误
void errorYibu() {
  // Future.error("Future 出错了") 发出一个错误
  // .then 抛出一个错误
  // catch 处理错误并又抛出一个错误
  // then(print, onError: (error) => print("then 中的onError:${error}")中的 onError 来处理catchError中抛出的错误
  Future.error("Future 出错了").then((_) {
    throw "new error";
  }).catchError((onError) {
    print("catchError:${onError}");
    // throw 'new error2';
  }).then(print, onError: (error) => print("then 中的onError:${error}"));
}
