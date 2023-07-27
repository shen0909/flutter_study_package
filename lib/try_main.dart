import 'dart:async';
import 'dart:convert';


Future<Album> fetchAlbum() async {
  var dio;
  final response = await dio.get('https://jsonplaceholder.typicode.com/albums/1');

  //HttpRequest.request('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int ? userId;
  final int ? id;
  final String ? title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}