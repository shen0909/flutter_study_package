//Person类
import 'dart:convert';

class Person {
  final String name;
  final int age;

  Person({required this.name, required this.age});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}

void main() {
  // 创建一个 Person 对象
  final person = Person(name: '朱一龙', age: 30);
  print("person:${person}");
  print("person_name:${person.name}  person_age:${person.age}");

  // 将 Person 对象转换为 JSON 格式
  final json1=person.toJson();
  print("tojson:${json1}");

  // 将 JSON 格式的数据解码为 Person 对象
  final jsonToPerson=Person.fromJson(json1);
  print("解码后:${jsonToPerson}");
  print("jsonToPerson_name:${jsonToPerson.name}  jsonToPerson_age:${jsonToPerson.age}\n");

  print("————————使用jsonEncode和jsonDecode——————————");
  //jsonEncode()将Dart 对象转换为为 JSON 格式的字符串。
  final person2=jsonEncode(person);
  print("jsonEncode_person2:${person2}");
  //jsonDecode() 方法会将 JSON 格式的字符串反序列化为 Dart 对象的实例。
  final data=jsonDecode(person2);
  print("jsonDecode_data:${data}");
}
