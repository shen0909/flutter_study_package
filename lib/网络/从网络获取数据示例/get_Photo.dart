import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//获取网络图片

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

//给方法添加了一个 http.Client 参数。这将使得该方法测试起来更容易同时也可以在不同环境中使用。
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  // print("response:${response.body}");

  //使用compute方法在后台处理数据
  return compute(parsePhotos, response.body);
}

//将响应的数据转换成List<Photo>类型
List<Photo> parsePhotos(String responseBody) {
  /*將解碼後的結果轉換成 Map<String, dynamic> 的列表
   *cast方法是将一个动态列表转换成指定的列表*/

  //现在的data是Map<String, dynamic>类型的列表，还需要转换成对象
  final data=jsonDecode(responseBody).cast<Map<String,dynamic>>();
  // print("data:${data}");
  /*data是一个Map<String, dynamic> 的列表
   *.mao方法遍历列表中的每一个元素，
   * ((item)=>Photo.fromJson(item))每一个元素都会调用 Photo.fromJson(json) 来将 JSON 对象转换为 Photo 对象
   * 这个过程会返回一个新的 Iterable<Photo>
   * .toList()方法将所有转换后的对象存储在一个新的列表中并返回*/
  final result= data.map<Photo>((item)=>Photo.fromJson(item)).toList();
  // print("result:${result}");
  return result;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text("从网络获取图片"),
        ),
        body: FutureBuilder<List<Photo>>(
          future: fetchPhotos(http.Client()),
          builder: (context,snapshot){
            if(snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            }
            else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
            }
            else {
            return const Center(
            child: CircularProgressIndicator(),
            );
            }
          },
        ),
      ),
    );
  }
}
class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Image.network(photos[index].thumbnailUrl);
      },
    );
  }
}