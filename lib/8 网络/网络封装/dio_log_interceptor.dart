//自定义dio拦截器
import 'package:dio/dio.dart';

class DioLogInterceptor extends Interceptor{

  ///请求前
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String requestStr = "==================== 请求前拦截——REQUEST ====================\n"
        "- URL:${options.baseUrl + options.path}\n"
        "- METHOD: ${options.method}\n";


    requestStr += "- HEADER:\n${options.headers.mapToStructureString()}\n";

    final data = options.data;
    if (data != null) {
      if (data is Map)
        requestStr += "- BODY:\n${data.mapToStructureString()}\n";
      else if (data is FormData) {
        final formDataMap = Map()..addEntries(data.fields)..addEntries(data.files);
        requestStr += "- BODY:\n${formDataMap.mapToStructureString()}\n";
      } else
        requestStr += "- BODY:\n${data.toString()}\n";
    }
    else{
      requestStr += "- BODY:options.data 为空\n";
    }
    print(requestStr);
    return handler.next(options);
  }

  ///响应前
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String responseStr = "\n==================== 响应前——RESPONSE ====================\n"
        "- URL:${response.realUri}\n";
    responseStr += "- METHOD:${response.requestOptions.method}\n";
    responseStr += "- HEADER:\n{";
    response.headers.forEach((key, list) => responseStr += "\n  " + "\"$key\" : \"$list\",");
    responseStr += "\n}\n";
    responseStr += "- STATUS: ${response.statusCode}\n";
    print(responseStr);
    return handler.next(response);
  }

  ///错误前
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorStr = "\n==================== 出错前——RESPONSE ====================\n"
        "- URL: ${err.requestOptions.baseUrl + err.requestOptions.path}\n"
        "- METHOD: ${err.requestOptions.method}\n";

    if (err.response != null && err.response!.data != null) {
      errorStr += "- HEADER:\n${err.response!.headers.map.mapToStructureString()}\n";
      print('╔ ${err.type.toString()}');
      // errorStr += "- ERROR:\n${_parseResponse(err.response!)}\n";
    } else {
      errorStr += "- ERRORTYPE: ${err.type}\n";
      errorStr += "- MSG: ${err.message}\n";
    }
    print(errorStr);
    return handler.next(err);
  }
}
///Map拓展，MAp转字符串输出
extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      this.forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr" +
              "\"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          result += "\n$indentationStr" + "\"$key\" : \"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

///List拓展，List转字符串输出
extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "$indentationStr[";
      this.forEach((value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$temp\",";
        } else if (value is List) {
          result += value.listToStructureString(indentation: indentation + 2);
        } else {
          result += "\n$indentationStr" + "\"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += "\n$indentationStr]";
    }

    return result;
  }
}