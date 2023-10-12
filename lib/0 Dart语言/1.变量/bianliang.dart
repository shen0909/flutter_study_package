void main() {
  //字符串类型
  vString();
  vNum();
  vList();
  vSet();
  vMap();
  v();
}

//Number类型
void vNum() {
  print("\n——————————————————————————Number类型——————————————————————————");
  int i = 10;
  double j = 120;
  print("i=$i\t j=$j");
  
  //使用 toStringAsFixed(). 指定小数点右边的位数
  print("i=${double.parse(i.toString())}\t j=${int.parse(j.toStringAsFixed(0))}");
  
  // 使用 toStringAsPrecision(): 指定字符串中的有效数字的位数。
  print("使用 toStringAsPrecision(): 指定字符串中的有效数字的位数。————> ${j.toStringAsPrecision(1)}");
  
  //类型转换
  print("i=${i.toDouble()}\t j=${j.toInt()}");
  print("数字类型转换成字符串类型————>num.toString():${j.toString()},j的类型:${j.toString().runtimeType}");
}

//String类型
void vString() {
  print("\n——————————————————————————String类型——————————————————————————");
  
  // 1、内嵌表达式
  // 2、使用+号可以连接多个字符串
  // 3、使用连续三个单引号或者三个双引号实现多行字符串对象的创建
  var s1 = """
  小杨是个好人，
  小杨是个善良的人。
  """;
  print(s1);
  //4、使用 r 前缀，可以创建 “原始 raw” 字符串,此时，字符串的转义字符不会被转换
  var sr = r"In a raw string, even \n isn't special.";
  print(sr);

//  检查一个字符串是否包含另一个字符串
  print("一个字符串是否包含另一个字符串:${s1.contains("好人") ? "true" : "false"}");

//  一个字符串是否以另一个字符串为开头?
  print("一个字符串是否以另一个字符串开头:${s1.startsWith("小沈") ? "true" : "false"}");

//  一个字符串是否以另一个字符串为结尾?
  var ss = "abc";
  print("一个字符串是否以另一个字符串为结尾:${ss.endsWith("c") ? "true" : "false"}");

//  查找一个字符串在另一个字符串中的位置。
  print("查找一个字符串在另一个字符串中的位置:${ss.indexOf("a")}");

//  字母大写转换
  print("首字母大写转换:${ss.toUpperCase()}");

//  字母小写转换
  var sss = "AKSJFOIWN";
  print("首字母大写转换:${sss.toLowerCase()}");

//  从字符串中提取数据
  var st = "xiaoyang喜欢xuexi  ";
  print("从字符串中提取数据:${st.substring(2,10)}");

//  使用字符串模式分割字符串-将一个字符串分割为子字符串列表
  print("使用字符串模式分割字符串:${st.split("xue")}");

  for (var char in 'hello'.split('')) {
    print(char);
  }

// 使用 trim() 移除首尾空格
  print("使用 trim() 移除首尾空格:${st.trim()}");

//  替换部分字符串，字符串是不可变的对象，也就是说字符串可以创建但是不能被修改，
//  方法 replaceAll() 返回一个新字符串， 并没有改变原始字符串
  var sth = "hello world!";
  print("替换部分字符:${sth.replaceAll(RegExp("world"), "小杨")}");

//  构建一个字符串,要以代码方式生成字符串，可以使用 StringBuffer.
//   在调用 toString() 之前， StringBuffer 不会生成新字符串对象。 writeAll() 的第二个参数为可选参数，用来指定分隔符
  var sb = StringBuffer();
  sb
    ..write("突然觉得我现在的状态是我这么多年来的常态")
    ..writeAll(["不自律、贪玩、懒惰"],"、")
    ..write(",其实全部都可以归结于小时候没有养成一个良好的习惯.");
  print("构建一个字符串:$sb");
}

//集合-List
void vList(){
  print("\n——————————————————————————List类型——————————————————————————");
//  lists 可以通过字面量来创建和初始化。
  var l1 = [1,2,3,4,5];
  print("l1的类型:${l1.runtimeType},l1=$l1");

//  添加一个元素到 list 对象
  l1.add(90);
  print("添加一个元素到 list 对象:${l1}");

//  添加多个元素到 list 对象。
  l1.addAll([900,100]);
  print("添加多个元素到 list 对象:$l1");

//  获取 list 长度
  print("获取 list 长度:${l1.length}");

//  移除一个元素到 list 对象
//  使用 indexOf() 方法查找一个对象在 list 中的下标值
  var index = l1.indexOf(900);
  print("查找下标值:${index}");
  print("移除一个元素:${l1.removeAt(index)}");
  print("移除数据后:${l1}");
  l1.remove(2);
  print("移除数据后:$l1");

//  移除多个元素到 list 对象
  /*l1.clear();
  print("清除所有:${l1}");*/

//  排序,使用 sort() 方法排序一个 list
  l1.add(9);
  l1.sort();
  print("排序:$l1");
}

//集合-set
void vSet(){
  print("\n——————————————————————————Set类型——————————————————————————");

//  在 Dart 中 Set 是一个元素唯一且无需的集合。
//  添加一个重复的元素是无效的
  var set1 = {"apple","ren","animals"};
  set1.add("apple");
  print("添加一个重复的元素是无效的:$set1");
  print("set的长度:${set1.length}");
  print("set中最后一个元素:${set1.last}");
  print("set中第一个元素:${set1.first}");

//  交集是另外两个 set 中的公共元素组成的 set
  var set2 = {"apple","animals","peopel","renrenr"};
  set2 = set2.intersection(set1);
  print("交集:$set2");
}

//集合-map
void vMap(){
  print("\n——————————————————————————Map类型——————————————————————————");

//  声明map可以用字变量语法
  var map1 = {
    "key1":"111",
    "key2":"222",
    "key3":["天天","学习","找意义"]
  };
  // var map2 = Map(); //或者map的构造函数

  print("map1的数据类型:${map1.runtimeType}");
  print("map1:$map1");

//  添加元素
  map1.addAll({"key4": "无数次和无聊的自己作斗争"});
  print("map1:$map1");

//  获取的所有的 key 是一个无序集合
  var key1 = map1.keys;
  print("map1的key值:$key1,key1的类型:${key1.runtimeType}");

//  获取所有的 value值,是一个可迭代 list 对象
  var values = map1.values;
  print("map1的values值:$values");

//  使用 containsKey() 方法检查一个 map 中是否包含某个key
  print("map1中是否包含key5?:${map1.containsKey("key5")}");

//  如果当且仅当该 key 不存在于 map 中，且要为这个 key 赋值， 可使用putIfAbsent（）方法。
  map1.putIfAbsent("key5", () => "这是一个新的数据");
  print("map1:$map1");
}

//公共集合方法
void v(){
  print("\n——————————————————————————公共的集合方法——————————————————————————");
  var mapf = {"abc","sdw","sdfwgs"};

//  1、使用 isEmpty 和 isNotEmpty 方法可以检查 list， set 或 map 对象中是否为空
//  2、使用 forEach() 可以让 list， set 或 map 对象中的每个元素都使用一个方法,
//  当在 map 对象上调用 `forEach() 方法时，函数必须带两个参数（key 和 value）
  mapf.forEach((element) =>print("forEach：$element"));

//  3、Iterable 提供 map() 方法，这个方法将所有结果返回到一个对象中,原数据不变
  print("全部转换成大写:${mapf.map((e) => e.toUpperCase())}");
  print("mapf:$mapf");

//  4、使用 map().toList() 或 map().toSet() ， 可以强制在返回的集合上调用的方法，用于将其转换为列表或集合。
  print("使用 map().toList() 或 map().toSet():${mapf.map((e) => e.toUpperCase()).toList()}");

//  5、使用 Iterable 的 where() 方法可以获取所有匹配条件的元素，并返回一个新的集合，其中只包含原始集合中满足函数条件的元素。
  print("使用 Iterable 的 where() 方法可以获取所有匹配条件的元素:${mapf.where((element) => element.contains("d"))}");

//  6、使用 any() 来检查集合中是否至少有一个元素满足条件
  print("至少有一个元素含d?\t${mapf.any((element) => element.contains("d"))}");

//  7、使用 every() 来检查集合中是否所有元素满足条件。
  print("所有元素都含d?\t${mapf.every((element) => element.contains("d"))}");
}
