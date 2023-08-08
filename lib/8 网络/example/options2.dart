import 'dart:io';
import 'package:dio/dio.dart';

void main() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://httpbin.org/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 10),
      // 5s
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'api': '1.0.0',
      },
      contentType: Headers.jsonContentType,
      // Transform the response data to a String encoded with UTF8.
      // The default value is [ResponseType.JSON].
      responseType: ResponseType.plain,
    ),
  );

  Response response;

  response = await dio.get('/get');
  print("ResponseType.plain->${response.data}\n");

  final responseMap = await dio.get(
    '/get',
    // Transform response data to Json Map
    options: Options(responseType: ResponseType.json),
  );
  print("ResponseType.json->${responseMap.data}\n");

  response = await dio.post(
    '/post',
    data: {
      'id': 8,
      'info': {'name': 'wendux', 'age': 25}
    },
    // Send data with "application/x-www-form-urlencoded" format
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
  );
  print("Headers.formUrlEncodedContentType->${response.data}\n");

  response = await dio.fetch(
    RequestOptions(path: 'https://baidu.com/'),
  );
  print("fetch->${response.data}\n");
}